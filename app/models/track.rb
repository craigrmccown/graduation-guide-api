class Track < ActiveRecord::Base
  include JsonSupport

  validates :name, presence: true
  validates :description, presence: true

  has_and_belongs_to_many :users
  has_and_belongs_to_many :courses
  belongs_to :major
end
