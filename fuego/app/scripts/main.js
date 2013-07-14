'use strict';

var Fuego = Fuego || {}, data;

Fuego = {
	init: function () {
		console.log('Loaded');
		Fuego.fetch();
	},

	fetch: function () {
	  d3.selectAll('path, polyline, polygon')
	    .attr('fill', function(d) {
	      var abbr = this.id.toLowerCase().replace(/_/g,'-');
	      var fires, json;

				d3.json('http://0.0.0.0:3000/counties/', function (json) {
				  json.forEach(function (object) {
				  	if (abbr == object.county.slug) {
				  		//console.log(object.county.fires.length)
				  		fires = object.county.fires.length;
				  	}
				  });
				  console.log(fires + ' ' + abbr);
				});
		});
	},

	_getColor: function (d) {
    return d > 12 ? '#800026' :
           d > 10  ? '#BD0026' :
           d > 8  ? '#E31A1C' :
           d > 6  ? '#FC4E2A' :
           d > 4   ? '#FD8D3C' :
           d > 2   ? '#FEB24C' :
           d > 1   ? '#FED976' :
           d > 0   ? '#FFEDA0' :
                      '#E2E2E2';
	}
}

jQuery(document).ready(function($) {
	Fuego.init();
});