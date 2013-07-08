App.Router.reopen({
  location: 'history',
  rootURL: '/'
});

App.Router.map(function () {
  // put your routes here
});

App.IndexRoute = Ember.Route.extend({
  model: function () {
    return App.County.all();
  }
});