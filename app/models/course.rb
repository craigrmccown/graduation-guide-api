class Course < ActiveRecord::Base
  include JsonSupport

  validates :name, presence: true
  validates :description, presence: true

  belongs_to :prereq
  has_and_belongs_to_many :majors
  has_and_belongs_to_many :minors
  has_and_belongs_to_many :tracks
end
