# Fire Scraper

This is a Rails app that displays the latest wildfire information in California. It scrapes the CAL FIRE Incidents
government site and grabs the info. From there, it stores the info in a Rails model and you, the user, get to see
all the *major* California fire incidents. 

_NOTE_: CAL FIRE only shows major wild fires, e.g, the San Gabriel Valley fire currently happening near Los Angeles.
Your local pyro's theatrics probably won't appear here.

# Features
- Sortable table of fire incidents
- Total acres burned (basic math stuff)
- All the cool kid tech (Rails, Coffeescript, Leaflet, Bootstrap, et al).

# Milestone
- Add proper GeoJSON of counties on fire 
- Realtime updated either via a Cron or some bleeding edge Rails 4 tech and XML


# About

This Rails project was built by Aaron Williams, a web developer and journalist who currently works for the Los Angeles Times.

