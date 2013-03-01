class Fire < ActiveRecord::Base
  attr_accessible :acreage, :date, :name, :containment, :location

  validates :acreage, :date, :name, :location, presence: true

  validates :location, uniqueness: true

  belongs_to :county
end