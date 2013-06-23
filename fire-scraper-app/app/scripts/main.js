/*global fireScraperApp, $*/
'use strict';


window.fireScraperApp = {
    Models: {},
    Collections: {},
    Views: {},
    Routers: {},
    init: function () {
        console.log('Hello from Backbone!');
    }
};

$(document).ready(function () {
    fireScraperApp.init();
});
