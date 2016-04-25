class Course < ActiveRecord::Base
  include JsonSupport

  json_embed :sections

  validates :name, presence: true
  validates :description, presence: true

  has_many :sections
  has_and_belongs_to_many :course_groups
  has_and_belongs_to_many :prereqs
  has_and_belongs_to_many :majors
  has_and_belongs_to_many :minors
  has_and_belongs_to_many :tracks
end
