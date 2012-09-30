class Fire < ActiveRecord::Base
  attr_accessible :acerage, :county_id, :date, :name, :containment

  validates :acerage, :date, :name, :county_id, presence: true

  belongs_to :county
end
