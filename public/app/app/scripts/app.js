/*global Ember */

var App = window.App = Ember.Application.create();

/* Order and include as you please. */
// require('scripts/routes/*');
// require('scripts/controllers/*');
require('scripts/models/*');
// require('scripts/views/*');

App.Router.map(function () {
  // put your routes here
  //this.resource( 'counties' );
});

App.IndexRoute = Ember.Route.extend({
  model: function () {
    return App.County.all();
  }
});