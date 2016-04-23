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
    query = ""
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
    roots.each { |root| root.load! Course.all }

    self.courses.each do |course|
      roots.each do |root|
        break if root.evaluate! course
      end
    end

    roots
  end
end
