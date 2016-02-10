class Role < ActiveRecord::Base
  validates :name, inclusion: { in: %w(admin student), message: 'invalid role name' }
  has_and_belongs_to_many :users

  def self.[](name)
      role = find_by name: name.to_s
      raise "role #{name} does not exist" if role.nil?
      role
  end
end
