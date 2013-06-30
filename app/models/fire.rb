class Fire < ActiveRecord::Base
  attr_accessible :acreage, :containment, :date, :location, :name

  validates :acreage, :date, :name, :location, presence: true

  validates :location, uniqueness: true

  belongs_to :county
end
