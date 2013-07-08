App.Router.reopen({
  location: 'history',
  rootURL: '/'
});

App.Router.map(function () {
  // put your routes here
  this.resource('counties')
});

App.IndexRoute = Ember.Route.extend({
  model: function () {
    return App.County.all();
  }
});

App.CountiesRoute = Ember.Route.extend({
	model: function () {
		return App.County.all()
	}
});