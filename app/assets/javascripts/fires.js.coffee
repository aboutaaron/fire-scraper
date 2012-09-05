# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
    # Tablesorter
    $("#fire-table").tablesorter()

    # Leaflet
    # Initialize the map object
    map = new L.Map("map",

      # Some basic options to keep the map still and prevent
      # the user from zooming and such.
      scrollWheelZoom: false
      touchZoom: false
      doubleClickZoom: false
      zoomControl: false
      dragging: false
    )

    # Prep the background tile layer graciously provided by stamen.com
    stamenUrl = "http://{s}.tile.stamen.com/toner/{z}/{x}/{y}.png"
    stamenAttribution = "Map tiles by <a href=\"http://stamen.com\">Stamen Design</a>, under <a href=\"http://creativecommons.org/licenses/by/3.0\">CC BY 3.0</a>. Data by <a href=\"http://openstreetmap.org\">OpenStreetMap</a>, under <a href=\"http://creativecommons.org/licenses/by-sa/3.0\">CC BY SA</a>."
    stamenLayer = new L.TileLayer(stamenUrl,
      maxZoom: 18
      attribution: stamenAttribution
    )

    # Set the center on our city of angels
    center = new L.LatLng(36.778261,-119.417932)
    map.setView center, 6

    # Load the background tiles
    map.addLayer stamenLayer

    # Create an empty layer where we will load the polygons
    featureLayer = new L.GeoJSON()

    # Set a default style for out the polygons will appear
    defaultStyle =
      color: "#950014"
      weight: 2
      opacity: 0.6
      fillOpacity: 0.1
      fillColor: "#950014"


    # Define what happens to each polygon just before it is loaded on to
    # the map. This is Leaflet's special way of goofing around with your
    # data, setting styles and regulating user interactions.
    onEachFeature = (feature, layer) ->

      # All we're doing for now is loading the default style.
      # But stay tuned.
      layer.setStyle defaultStyle


    # Add the GeoJSON to the layer. `boundaries` is defined in the external
    # GeoJSON file that I've loaded in the <head> of this HTML document.
    featureLayer = L.geoJson(boundaries,

      # And link up the function to run when loading each feature
      onEachFeature: onEachFeature
    )

    # Finally, add the layer to the map.
    map.addLayer featureLayer