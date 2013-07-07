/*global Ember */

var App = window.App = Ember.Application.create();

/* Order and include as you please. */
// require('scripts/routes/*');
// require('scripts/controllers/*');
// require('scripts/models/*');
// require('scripts/views/*');

App.Router.map(function () {
  // put your routes here
  this.resource( 'counties' );
});

App.IndexRoute = Ember.Route.extend({
  model: function () {
    return App.County.all();
  }
});

// Model
App.County = Ember.Object.extend();

App.County.reopenClass({
	all: function() {
		return $.getJSON("/scripts/temp_counties.json").then(
			function (response) {
			var counties = [];
			console.log(response)

			response.forEach( function(county) {
				counties.push( App.County.create(county) );

				return counties;
			});
		});
	}
});

App.CountyRoute = Ember.Route.extend({
	setupController: function (controller) {
		controller.set();
	}
});
