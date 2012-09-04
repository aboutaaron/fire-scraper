require 'mechanize'

a = Mechanize.new

a.get("http://cdfdata.fire.ca.gov/incidents/incidents_current?sort=incident_priority&pc=all")

# Arrays
fire_names = []
fire_counties = []
fire_addresses = []
# fire_admin_units = []
total_acres_burned = []
percentage_of_fires_contained = []
dates_fires_started = []
last_date_fires_updated = []

# Name of the header
a.page.search(".incident_table")[1..109].each do |fire|
    # Fire name
    fire_names << fire.search(".odd:nth-child(2) td:nth-child(2)").text
    # County
    fire_counties << fire.search(":nth-child(3) td:nth-child(2)").text

    # Address
    fire_addresses << fire.search(".odd:nth-child(4) td:nth-child(2)").text

    # Administrative UNit
    # puts fire.search(":nth-child(5) td:nth-child(2)").text

    # Status/Notes
    notes = fire.search(".odd:nth-child(6) td:nth-child(2)").text
    # Acres burned
    total_acres_burned << notes.match(/^[,0-9]*/).to_s.gsub(',','').to_i
    # Percentage contained
    attempt = notes.match(/\d%.contained|.\d\d%.contained/).to_s

    if attempt != ""
        percentage_contained = attempt
        percentage_of_fires_contained << percentage_contained
    else
        percentage_contained = "No value given"
        percentage_of_fires_contained << percentage_contained
    end

    # Date Started
    dates_fires_started << fire.search(":nth-child(7) td:nth-child(2)").text
    # Last Update
    last_date_fires_updated << fire.search(".odd:nth-child(8) td:nth-child(2)").text
end