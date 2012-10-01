class Fire < ActiveRecord::Base
  attr_accessible :acreage, :county_id, :date, :name, :containment

  validates :acreage, :date, :name, :county_id, presence: true

  validates :name, uniqueness: true

  belongs_to :county
end
