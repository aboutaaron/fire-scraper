class County < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  attr_accessible :name, :latitude, :longitude, :slug
  validates :name, uniqueness: true, presence: true
  has_many :fires

  geocoded_by :full_address
  after_validation :geocode

  def full_address
    name + " County, California, USA"
  end
end
