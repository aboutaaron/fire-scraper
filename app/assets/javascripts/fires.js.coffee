# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
    # Tablesorter
    $("#fire-table").tablesorter()

    # Leaflet
    map = L.map("map").setView([36.778261, -119.417932], 6)
    L.tileLayer("http://{s}.tile.stamen.com/terrain/{z}/{x}/{y}.png",
        attribution: "Map tiles by <a href=\"http://stamen.com\">Stamen Design</a>, under <a href=\"http://creativecommons.org/licenses/by/3.0\">CC BY 3.0</a>. Data by <a href=\"http://openstreetmap.org\">OpenStreetMap</a>, under <a href=\"http://creativecommons.org/licenses/by-sa/3.0\">CC BY SA</a>."
        maxZoom: 18
    ).addTo map