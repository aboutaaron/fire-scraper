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