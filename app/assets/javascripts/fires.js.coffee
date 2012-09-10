# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

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
      scrollWheelZoom: false
      touchZoom: false
      doubleClickZoom: false
      zoomControl: false
      dragging: false
    )

    # Stamen Layer
    # http://maps.stamen.com/#toner/12/37.7706/-122.3782
    layer = new L.StamenTileLayer("terrain")

    # Set the center to California
    center = new L.LatLng(36.778261,-119.417932)
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

      # Create a self-invoking function that passes in the layer
      # and the properties associated with this particular record.
      ((layer, properties) ->

        # Create a mouseover event
        layer.on "mouseover", (e) ->

          # Change the style to the highlighted version
          layer.setStyle highlightStyle

          # Create a popup with a unique ID linked to this record
          popup = $("<div></div>",
            id: "popup"
            class: "howdy"
            css:
              position: "absolute"
              bottom: "85px"
              left: "50px"
              zIndex: 1002
              backgroundColor: "white"
              padding: "8px"
              border: "1px solid #ccc"
          )

          # Insert a headline into that popup
          hed = $("<div></div>",
            text: properties.NAME + " County"
            css:
              fontSize: "16px"
              marginBottom: "3px"
          ).appendTo(popup)

          # Add the popup to the map
          popup.appendTo "#map"


        # Create a mouseout event that undoes the mouseover changes
        layer.on "mouseout", (e) ->

          # Start by reverting the style back
          layer.setStyle defaultStyle

          # And then destroying the popup
          $("#popup").remove()


      # Close the "anonymous" wrapper function, and call it while passing
      # in the variables necessary to make the events work the way we want.
      ) layer, feature.properties


    # Add the GeoJSON to the layer. `boundaries` is defined in the external
    # GeoJSON file that I've loaded in the <head> of this HTML document.
    featureLayer = L.geoJson(boundaries,

      # And link up the function to run when loading each feature
      onEachFeature: onEachFeature
    )

    # Finally, add the layer to the map.
    map.addLayer featureLayer