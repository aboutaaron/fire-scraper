App.Router.reopen({
  location: 'history',
  rootURL: '/'
});

App.Router.map(function () {
  // put your routes here
  this.resource('counties', function () {
  	this.route('slug', {path: '/:slug' })
  });
});

App.CountiesRoute = Ember.Route.extend({
  model: function () {
    return App.County.all();
  }
});

App.CountiesSlugRoute = Ember.Route.extend({
	model: function (params) {
		return this.modelFor('counties').findCountyById(params.slug);
	}
});