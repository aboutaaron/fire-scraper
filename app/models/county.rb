class County < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude
  validates :name, uniqueness: true, presence: true
  has_many :fires

  geocoded_by :full_address
  after_validation :geocode

  def full_address
    name + " County, California, USA"
  end
end
