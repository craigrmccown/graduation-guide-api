class User < ActiveRecord::Base
  include JsonSupport
  include BCrypt

  json_exclude :encrypted_password
  json_nest :roles, :majors, :tracks, :minors

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
end
