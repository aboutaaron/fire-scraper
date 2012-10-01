class County < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude
  validates :name, uniqueness: true, presence: true
  has_many :fires

  geocoded_by :name
  after_validation :geocode
end
