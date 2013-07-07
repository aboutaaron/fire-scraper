App.CountiesRoute = Ember.Route.extend({
	renderTemplate: function () {
		this.render('app/templates/counties', { into: 'app/templates/counties' });
	}
})