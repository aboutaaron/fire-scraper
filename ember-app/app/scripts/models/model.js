// Model
App.County = Ember.Object.extend();

App.County.reopenClass({
	all: function() {
		return $.getJSON("http://0.0.0.0:3000/counties.json").then(
			function (response) {
			var counties = [];

			response.forEach( function(county) {
				counties.push( App.County.create(county) );
			});

			return counties;
		});
	}
});

// For Ember-Data
/*
App.Store = DS.Store.extend()

App.County = Ember.Model.extend({
	name: DS.attr('string'),
	latitude: DS.attr('integer'),
	longitude: DS.attr('integer'),
	coordinates: function () {
		var coordinates = [],
			latitude = this.get('latitude'),
			longitude = this.get('longitude');
		coordinates.push(latitude);
		coordinates.push(longitude);

		return coordinates;
	}.property('latitude', 'longitude')
});
*/