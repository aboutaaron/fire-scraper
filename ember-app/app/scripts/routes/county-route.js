App.CountyRoute = Ember.Route.extend({
	model: function (params) {
		return jQuery.getJSON('/counties/' + params.slug)
	},

	seralize: function (model) {
		return { slug: model.slug };
	}
});
