// Model
App.County = Ember.Object.extend();

App.County.reopenClass({
	all: function() {
		var counties = Ember.ArrayProxy.create({ content: [] });
		$.getJSON("http://0.0.0.0:3000/counties.json").then(
			function (response) {
				response.forEach( function (county) {
					counties.pushObject(App.County.create(county));
				});
		});
		return counties;
	}
});