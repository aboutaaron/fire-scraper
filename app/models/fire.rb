class Fire < ActiveRecord::Base
  attr_accessible :acreage, :containment, :county_id, :date, :location, :name
end
