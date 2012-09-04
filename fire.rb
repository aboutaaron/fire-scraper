require 'mechanize'

a = Mechanize.new

a.get("http://cdfdata.fire.ca.gov/incidents/incidents_current?sort=incident_priority&pc=all")

# Name of the header
a.page.search(".incident_table").each do |fire|
    # Fire name
    puts fire.search(".odd:nth-child(2) td:nth-child(2)").text
    # County
    puts fire.search(":nth-child(3) td:nth-child(2)").text
    # Location
    puts fire.search(".odd:nth-child(4) td:nth-child(2)").text
    # Administrative UNit
    puts fire.search(":nth-child(5) td:nth-child(2)").text
    # Status/Notes
    puts fire.search(".odd:nth-child(6) td:nth-child(2)").text
    # Date Started
    puts fire.search(":nth-child(7) td:nth-child(2)").text
    # Last Update
    puts fire.search(".odd:nth-child(8) td:nth-child(2)").text

end

