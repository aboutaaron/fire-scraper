class Fire < ActiveRecord::Base
  attr_accessible :acreage, :county_id, :date, :name, :containment, :location

  validates :acreage, :date, :name, :county_id, :location, presence: true

  validates :location, uniqueness: true

  belongs_to :county
end
