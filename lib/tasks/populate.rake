require 'mechanize'
require 'chronic'

namespace :populate do
    desc 'import county information from Cal Fire'
    task :counties => :environment do
        a = Mechanize.new
        a.get('http://cdfdata.fire.ca.gov/incidents/incidents_current?sort=incident_priority&pc=all')
        a.page.search(".incident_table").drop(1).each do |incident|
            begin
                county = County.new
                county.name = incident.search(":nth-child(3) td:nth-child(2)").text.gsub(/\b\sCounty|Counties/,'').gsub(/\W$/,"").gsub(/\s$/,"")
                county.save!
            rescue StandardError => e
                puts "Error: #{e}"
            end
        end
    end

    desc 'import fire information from Cal Fire'
    task :fires => :environment do
        a = Mechanize.new
        a.get('http://cdfdata.fire.ca.gov/incidents/incidents_current?sort=incident_priority&pc=all')

        # .incident_table contains information for each individual fire
        # the first instance of .incident_table is empty so we use the `drop`
        # method to make sure we ignore it
        a.page.search(".incident_table").drop(1).each do |incident|
            # Rescue block!
            begin
                # Create a fire object
                fire = Fire.new

                # Aside: A bunch of fire metadata is stores in one table
                # so we're gonna store it early now and parse it down below
                metadata = incident.search(".odd:nth-child(6) td:nth-child(2)").text

                # Fire name
                fire.name = incident.search(".odd:nth-child(2) td:nth-child(2)").text

                # Date of Fire
                fire.date = Chronic::parse(incident.search(".even:nth-child(7) td:nth-child(2) , .even:nth-child(8) td:nth-child(2)").text)

                # Fire location
                fire.location = incident.search(".odd:nth-child(4) td:nth-child(2)").text

                # Acres burned
                fire.acreage = metadata.match(/^[,0-9]*/).to_s.gsub(',','').to_i

                # Percentage contained
                contained = metadata.match(/\d*%/).to_s.gsub('%','').to_i
                if contained != ""
                    fire.containment = contained
                else
                    fire.containment = 0
                end

                # County ID
                this_county = fire.search(":nth-child(3) td:nth-child(2)").text.gsub(/\b\sCounty|Counties/,'').gsub(/\W$/,"").gsub(/\s$/,"")
                fire.county_id = County.find_by_name(this_county).id

                # Save Fire
                fire.save!
            rescue StandardError => e
                puts "There was an error: #{e}"
            end
        end
    end
end