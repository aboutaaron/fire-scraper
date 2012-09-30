class Fire < ActiveRecord::Base
  attr_accessible :acerage, :county_id, :date, :name, :containment

  validates :acerage, :date, :name, presence: true

  belongs_to :county
end
