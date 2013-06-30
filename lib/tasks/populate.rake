require 'mechanize'
require 'chronic'

namespace :app do
  desc 'import fire information from Cal Fire'
  task :import => :environment do
    a = Mechanize.new
    a.get('http://cdfdata.fire.ca.gov/incidents/incidents_current?sort=incident_priority&pc=all')

    # .incident_table contains information for each individual fire
    # the first instance of .incident_table is empty so we use the `drop`
    # method to make sure we ignore it
    a.page.search(".incident_table").drop(1).each do |incident|
      # A bunch of fire metadata is stores in one table
      # so we're gonna store it early now and parse it later
      metadata = incident.search(".odd:nth-child(6) td:nth-child(2)").text

      # Store the name of the county and then create it if it doesn't exist
      @county = incident.search(":nth-child(3) td:nth-child(2)").text.gsub(/\b\sCounty|Counties/,'').gsub(/\W$/,"").gsub(/\s$/,"")
      County.where(:name => @county).first_or_create

      # Store the fire name and then create it if it doesn't exist
      @fire = incident.search(".odd:nth-child(2) td:nth-child(2)").text.gsub(/\W$/,'')
      Fire.where(:name => @fire).first_or_create do |fire|
        fire.date = Chronic::parse(incident.search(".even:nth-child(7) td:nth-child(2) , .even:nth-child(8) td:nth-child(2)").text)
        fire.location = incident.search(".odd:nth-child(4) td:nth-child(2)").text
        fire.acreage = metadata.match(/^[,0-9]*/).to_s.gsub(',','').to_i
        fire.county_id = County.find_by_name(@county).id

        contained = metadata.match(/\d*%/).to_s.gsub('%','').to_i
        if contained != ""
            fire.containment = contained
        else
            fire.containment = 0
        end
      end

    end
  end
end