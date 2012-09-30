class Fire < ActiveRecord::Base
  attr_accessible :acerage, :county_id, :date, :name

  validates :acerage, :date, :name, presence: true

  belongs_to :county
end
