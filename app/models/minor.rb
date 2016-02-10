class Minor < ActiveRecord::Base
  include JsonSupport

  validates :name, presence: true
  validates :description, presence: true

  has_and_belongs_to_many :users
  has_and_belongs_to_many :courses
end
