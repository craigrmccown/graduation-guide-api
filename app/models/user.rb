class User < ActiveRecord::Base
  include JsonSupport
  include BCrypt

  json_exclude :encrypted_password
  json_embed :roles, :majors, :tracks, :minors

  validates :email, format: { with: /\A.+@.+\z/, message: 'must supply a valid email' }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :encrypted_password, presence: true

  has_and_belongs_to_many :roles
  has_and_belongs_to_many :majors
  has_and_belongs_to_many :minors
  has_and_belongs_to_many :tracks
  has_and_belongs_to_many :courses

  def password=(plaintext)
    self.encrypted_password = Password.create(plaintext, :cost => 5).to_s
  end 

  def has_matching_password?(plaintext)
    Password.new(encrypted_password) == plaintext
  end 

  def has_role?(role)
    roles.where(id: role.id).any?
  end

  def create_student!
    roles << Role[:student]
    save!
  end


  def requirement_tree
    lookup = {}
    query = "
      with recursive requirement_tree as (
        select
          requirements.*,
          requirements.priority as root_priority,
          0 as level
        from requirements
        join majors_requirements
          on requirements.id = majors_requirements.requirement_id
        join majors_users
          on majors_requirements.major_id = majors_users.major_id
        where majors_users.user_id = #{self.id}
          and parent_id is null
        union
        select
          requirements.*,
          requirements.priority as root_priority,
          0 as level
        from requirements
        join requirements_tracks
          on requirements.id = requirements_tracks.requirement_id
        join tracks_users
          on requirements_tracks.track_id = tracks_users.track_id
        where tracks_users.user_id = #{self.id}
          and parent_id is null
        union
        select
          requirements.*,
          requirements.priority as root_priority,
          0 as level
        from requirements
        join minors_requirements
          on requirements.id = minors_requirements.requirement_id
        join minors_users
          on minors_requirements.minor_id = minors_users.minor_id
        where minors_users.user_id = #{self.id}
          and parent_id is null
        union all
        select
          requirements.*,
          requirement_tree.root_priority,
          requirement_tree.level + 1 as level
        from requirements
        join requirement_tree
          on requirements.parent_id = requirement_tree.id
      )
      select distinct #{Requirement.column_names.join ','}
      from requirement_tree
      order by root_priority, level
    "
    requirements = Requirement.find_by_sql query

    requirements.each do |requirement|
      if lookup[requirement.id].nil?
        lookup[requirement.id] = requirement
      end

      unless requirement.parent_id.nil?
        lookup[requirement.parent_id].children << requirement
      end
    end

    roots = requirements.select { |requirement| requirement.parent_id.nil? }

    self.courses.each do |course|
      unsatisfied = roots.select { |root| not root.satisfied? }

      unsatisfied.each do |root|
        break if root.evaluate! course
      end
    end

    roots
  end

  def prereq_tree
    lookup = {}
    query = "
      with recursive prereq_tree as (
        select * from prereqs
        where parent_id is null
        union all
        select prereqs.*
        from prereqs
        join prereq_tree
          on prereqs.parent_id = prereq_tree.id
      )
      select * from prereq_tree
    "
    prereqs = Prereq.find_by_sql query

    prereqs.each do |prereq|
      if lookup[prereq.id].nil?
        lookup[prereq.id] = prereq
      end

      unless prereq.parent_id.nil?
        lookup[prereq.parent_id].children << prereq
      end
    end

    roots = prereqs.select { |prereq| prereq.parent_id.nil? }
    roots.each { |root| root.evaluate! self.courses }

    roots
  end
end
