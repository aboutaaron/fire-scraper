require 'mechanize'
require 'chronic'

namespace :app do
  desc 'import fire information from Cal Fire'
  task :import => :environment do
    a = Mechanize.new
    a.get('http://cdfdata.fire.ca.gov/incidents/incidents_current?sort=incident_priority&pc=all')

    # .incident_table contains fire. Drop the first table since it's empty
    a.page.search(".incident_table").drop(1).each do |incident|
      # Store metadata
      metadata = incident.search(".odd:nth-child(6) td:nth-child(2)").text

      # Store the name of the county and then create it if it doesn't exist
      @county = incident.search(":nth-child(3) td:nth-child(2)").text.gsub(/\b\sCounty|Counties/,'').gsub(/\W$/,"").gsub(/\s$/,"")
      County.where(:name => @county).first_or_create

      # Store the fire name and then create it if it doesn't exist. Update if it does.
      @fire = incident.search(".odd:nth-child(2) td:nth-child(2)").text.gsub(/\W$/,'')
      fire = Fire.where(:name => @fire).first_or_initialize
      fire.update_attributes(
        :date => Chronic::parse(incident.search(".even:nth-child(7) td:nth-child(2) , .even:nth-child(8) td:nth-child(2)").text),
        :location => incident.search(".odd:nth-child(4) td:nth-child(2)").text,
        :acreage => metadata.match(/^[,0-9]*/).to_s.gsub(',','').to_i,
        :county_id => County.find_by_name(@county).id,
        :containment => metadata.match(/\d*%/).to_s.gsub('%','').to_i,
        :active => true if metadata.match(/\d*%/).to_s.gsub('%','').to_i < 100
      )
    end
  end
end