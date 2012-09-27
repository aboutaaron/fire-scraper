# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

###
$ ->
    # Tablesorter
    $("#fire-table").tablesorter()

    # Setting media query
    # Not working, but potentional is here
    mobileMediaQuery = window.matchMedia("(max-width: 767px)")


    # Leaflet
    # Initialize the map object
    map = new L.Map("map",

      # Some basic options to keep the map still and prevent
      # the user from zooming and such.
      scrollWheelZoom: true
      touchZoom: true
      doubleClickZoom: true
      zoomControl: true
      dragging: true
    )

    # Stamen Layer
    # http://maps.stamen.com/#toner/12/37.7706/-122.3782
    layer = new L.StamenTileLayer("terrain")

    # Set the center to California
    center = new L.LatLng(37.5,-118.4)
    map.setView center, 6

    # Load the background tiles
    map.addLayer layer

    # Create an empty layer where we will load the polygons
    featureLayer = new L.GeoJSON()

    # Set a default style for out the polygons will appear
    defaultStyle =
      color: "#262626"
      weight: 2
      opacity: 0.6
      fillOpacity: 0.1
      fillColor: "#262626"

    # Highlight color
    highlightStyle =
      color: "#950014"
      weight: 3
      opacity: 0.6
      fillOpacity: 0.65
      fillColor: "#950014"


    # Define what happens to each polygon just before it is loaded on to
    # the map. This is Leaflet's special way of goofing around with your
    # data, setting styles and regulating user interactions.

    onEachFeature = (feature, layer) ->

      # Load the default style.
      layer.setStyle defaultStyle

    # Add the GeoJSON to the layer. `boundaries` is defined in the external
    # GeoJSON file that I've loaded in the <head> of this HTML document.
    featureLayer = L.geoJson(boundaries,

      # And link up the function to run when loading each feature
      onEachFeature: onEachFeature
    )

    # Finally, add the layer to the map.
    map.addLayer featureLayer

    # Setting chloropath colors
    getColor = (d) ->
      (if d > 10 then "#800026" else (if d > 8 then "#BD0026" else (if d > 6 then "#E31A1C" else (if d > 4 then "#FC4E2A" else (if d > 3 then "#FD8D3C" else (if d > 2 then "#FEB24C" else (if d > 1 then "#FED976" else "#FFEDA0")))))))


    # Adding style to map
    style = (feature) ->
      fillColor: getColor(feature.properties.FIRES)
      weight: 2
      opacity: 1
      color: "white"
      dashArray: "0"
      fillOpacity: 0.7
    L.geoJson(boundaries,
      style: style
    ).addTo map

    # Onto highlightStyle

    highlightFeature = (e) ->
      layer = e.target
      layer.setStyle
        weight: 5
        color: "#666"
        dashArray: ""
        fillOpacity: 0.7

      layer.bringToFront()  if not L.Browser.ie and not L.Browser.

      info.update layer.feature.properties

    # Reset the mouseout
    resetHighlight = (e) ->
      geojson.resetStyle e.target

      info.update()

    zoomToFeature = (e) ->
      map.fitBounds e.target.getBounds()

    onEachFeature = (feature, layer) ->
      layer.on
        mouseover: highlightFeature
        mouseout: resetHighlight
        click: zoomToFeature

    geojson = L.geoJson(boundaries,
      style: style
      onEachFeature: onEachFeature
    ).addTo(map)

    # Hover pop ups
    info = L.control()
    info.onAdd = (map) ->
      @_div = L.DomUtil.create("div", "info") # create a div with a class "info"
      @update()
      @_div


    # method that we will use to update the control based on feature properties passed
    info.update = (props) ->
      @_div.innerHTML = "<h4>Wildfires in California | 2012 </h4>" + ((if props then "<b>" + props.NAME + "</b><br />" + props.FIRES + " people / mi<sup>2</sup>" else "Hover over a county"))

    info.addTo map

    # Legend
    legend = L.control(position: "bottomright")
    legend.onAdd = (map) ->
      div = L.DomUtil.create("div", "info legend")
      grades = [0, 1, 2, 3, 4, 6, 8, 10]
      labels = []

      # loop through our density intervals and generate a label with a colored square for each interval
      i = 0

      while i < grades.length
        div.innerHTML += "<i style=\"background:" + getColor(grades[i] + 1) + "\"></i> " + grades[i] + ((if grades[i + 1] then "&ndash;" + grades[i + 1] + "<br>" else "+"))
        i++
      div

    legend.addTo map