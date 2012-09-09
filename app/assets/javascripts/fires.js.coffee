# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

###

$ ->
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
    url = "http://{s}.tile.cloudmade.com/0064577453aa486d98cec7f0ef57578f/997/256/{z}/{x}/{y}.png"
    attribution = "Map data &copy; <a href=\"http://openstreetmap.org\">OpenStreetMap</a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, Imagery © <a href=\"http://cloudmade.com\">CloudMade</a>"
    stamenLayer = new L.TileLayer(url,
      maxZoom: 18
      attribution: attribution
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

    ###