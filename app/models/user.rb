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
          *,
          priority as root_priority,
          0 as level
        from requirements
        where major_id in (
          select major_id from majors_users
          where user_id = #{self.id}
        )
          and parent_id is null
        union
        select
          *,
          priority as root_priority,
          0 as level
        from requirements
        where track_id in (
          select track_id from tracks_users
          where user_id = #{self.id}
        )
          and parent_id is null
        union
        select
          *,
          priority as root_priority,
          0 as level
        from requirements
        where minor_id in (
          select minor_id from minors_users
          where user_id = #{self.id}
        )
          and parent_id is null
        union all
        select
          requirements.*,
          requirements_tree.root_priority,
          requirements_tree.level + 1 as level
        from requirements
        join requirement_tree
          on requirements.parent_id = requirements_tree.id
      )
      select * from requirement_tree
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
      roots.each { |root| root.evaluate! course }
    end

    roots
  end
end
