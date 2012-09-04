class Fire < ActiveRecord::Base
  attr_accessible :date_fires_started, :fire_address, :fire_contained, :fire_county, :fire_name, :last_date_fire_updated, :total_acres_burned
end
