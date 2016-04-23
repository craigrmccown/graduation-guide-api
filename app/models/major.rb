class Major < ActiveRecord::Base
  include JsonSupport

  json_embed :tracks

  validates :name, presence: true
  validates :description, presence: true

  has_and_belongs_to_many :users
  has_many :tracks
end
