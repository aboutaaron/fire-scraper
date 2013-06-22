class Fire < ActiveRecord::Base
  attr_accessible :acreage, :containment, :county_id, :date, :location, :name

  validates :acreage, :date, :name, :county_id, :location, presence: true

  validates :location, uniqueness: true

  belongs_to :county
end
