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
    return ['red', 'yellow', 'blue'];
  }
});

// Model
App.County = Ember.object.extend();

App.County.reopenClass({
	all: function() {
		return $.getJSON("/counties.json").then(
			function (response) {
			
				
			response.
		})
	}
})

App.CountyRoute = Ember.Route.extend({
	setupController: function (controller) {
		controller.set();
	}
});
