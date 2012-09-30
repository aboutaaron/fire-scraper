require 'mechanize'
namespace :county do
    desc "grab counties from CAL FIRE website"
    task :import => :environment do
        a = Mechanize.new
        a.get("http://cdfdata.fire.ca.gov/incidents/incidents_current?sort=incident_priority&pc=all")
        counties = []
        a.page.search(".incident_table").drop(1).each do |x|
            my_county = County.new
            begin
                counties << x.search(":nth-child(3) td:nth-child(2)").text
                counties.each do |z|
                    my_county.name = z
                end
                my_county.save!
                puts "#{my_county.name} added..."
                puts
            rescue StandardError => e
                puts "Value could not be saved because #{e}"
            end
        end
    end
    desc "retrieve fires from the CAL FIRE website"
    task :fires => :environment do
        a = Mechanize.new
        a.get("http://cdfdata.fire.ca.gov/incidents/incidents_current?sort=incident_priority&pc=all")
        a.page.search(".incident_table").drop(1).each do |fire|


        end
    end
end