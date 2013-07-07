// Model
App.County = Ember.Object.extend();

App.County.reopenClass({
	all: function() {
		return $.getJSON("/scripts/temp_counties.json").then(
			function (response) {
			var counties = [];

			response.forEach( function(county) {
				counties.push( App.County.create(county) );
			});

			return counties;
		});
	}
});