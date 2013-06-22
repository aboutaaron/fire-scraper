require 'mechanize'
namespace :populate do
    desc "grab counties from CAL FIRE website"
    task :counties => :environment do
        a = Mechanize.new
        a.get("http://cdfdata.fire.ca.gov/incidents/incidents_current?sort=incident_priority&pc=all")
        counties = []
        a.page.search(".incident_table").drop(1).each do |x|
            my_county = County.new
            begin
                counties << x.search(":nth-child(3) td:nth-child(2)").text.gsub(/\b\sCounty|Counties/,'').gsub(/\W$/,"").gsub(/\s$/,"")
                counties.each do |z|
                    my_county.name = z
                end
                my_county.save!
                puts "#{my_county.name} added..."
                puts
            rescue StandardError => e
                puts "Value could not be saved because #{e}"
                puts
            end
        end
    end
    desc "retrieve fires from the CAL FIRE website"
    task :fires => :environment do
        a = Mechanize.new
        a.get("http://cdfdata.fire.ca.gov/incidents/incidents_current?sort=incident_priority&pc=all")
        # Array setup for values
        names = []
        dates = []
        acres = []
        locations =[]
        contained = []
        counties_arr = []
        a.page.search(".incident_table").drop(1).each do |fire|
            # New Fire instance
            f = Fire.new
            begin
                ##################
                # Name of the fire
                ##################
                names << fire.search(".odd:nth-child(2) td:nth-child(2)").text
                names.each do |val|
                    f.name = val
                end
                puts "This fire's name is #{f.name}"

                #######################
                # Date the fire started
                #######################
                dates << fire.search(":nth-child(7) td:nth-child(2)").text
                dates.each do |val|
                    f.date = val
                end
                puts "This fire started on #{f.date}"

                #####################
                # Fire location notes
                #####################
                locations << fire.search(".odd:nth-child(4) td:nth-child(2)").text
                locations.each do |val|
                    f.location = val
                end
                puts "The fire happed at #{f.location}"

                #============================================================
                # Table value with acres burned, containment and other notes
                notes = fire.search(".odd:nth-child(6) td:nth-child(2)").text
                #============================================================

                ##############
                # Acres burned
                ##############
                acres << notes.match(/^[,0-9]*/).to_s.gsub(',','').to_i
                acres.each do |val|
                    f.acreage = val
                end
                puts "#{f.acreage} acres were burned from this fire"

                ##################################
                # Percentage of the fire contained
                ##################################
                attempt = notes.match(/\d%.contained|.\d\d%.contained/).to_s
                if attempt != ""
                    percentage_contained = attempt
                    contained << percentage_contained
                else
                    percentage_contained = 0
                    contained << percentage_contained
                end
                contained.each do |val|
                    f.containment = val
                end
                puts "#{f.containment} percent of the fire was contained"

                #################
                # County location
                #################
                county_name = fire.search(":nth-child(3) td:nth-child(2)").text.gsub(/\b\sCounty|Counties/,'').gsub(/\W$/,"").gsub(/\s$/,"")
                counties_arr << County.find_by_name(county_name).id
                counties_arr.each do |val|
                    f.county_id = val
                end
                puts "The ID was #{f.county_id}"

                # Save the bitch
                f.save!
                puts "All done."
                puts

            rescue StandardError => e
                puts
                puts "Value could not be save because #{e}"
                puts
            end
        end
    end
end