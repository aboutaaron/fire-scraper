var Fuego = Fuego || {}, data;

Fuego = {
	init: function () {
		console.log('Loaded');
		Fuego.fetch();
	},

	fetch: function () {
		d3.json('http://0.0.0.0:3000/counties/', function (err, json) {
		  if (err) console.warn(err);
		  
		  json.forEach( function (object) {
		  	Fuego.paint(object);
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
	},

	paint: function (object) {
		d3.select('path, polyline, polygon')
			.attr('fill', function (d) {
				var countyId = this.id;
				var fires;

				// if the county if and json dump match
				if (countyId == object.county.name)
					return Fuego._getColor(object.county.fires.length);
			});
			//return Fuego._getColor(fires)
	}
}

jQuery(document).ready(function($) {
	Fuego.init();
});