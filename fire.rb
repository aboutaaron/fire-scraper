require 'mechanize'

a = Mechanize.new

a.get("http://cdfdata.fire.ca.gov/incidents/incidents_current")

