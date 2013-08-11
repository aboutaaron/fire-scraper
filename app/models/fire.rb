class Fire < ActiveRecord::Base
  attr_accessible :acreage, :containment, :date, :location, :name, :county_id, :active

  validates :acreage, :date, :name, :location, :county_id, presence: true

  validates :location, uniqueness: true

  belongs_to :county
end
