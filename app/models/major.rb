class Major < ActiveRecord::Base
  validate :name, presence: true
  validate :description, presence: true

  has_and_belongs_to_many :users
end
