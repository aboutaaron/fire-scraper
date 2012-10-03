class County < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude
  validates :name, uniqueness: true, presence: true
  has_many :fires

  geocoded_by :full_address
  after_validation :geocode

  def full_address
    name + ", California, USA"
  end

  extend FriendlyId
  friendly_id :name


  def next
    county.where("id > ?", id).first
  end

  def prev
    county.where("id < ?", id).first
  end
end
