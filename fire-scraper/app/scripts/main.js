/*global fireScraper, $*/
'use strict';


window.fireScraper = {
    Models: {},
    Collections: {},
    Views: {},
    Routers: {},
    init: function () {
        console.log('Hello from Backbone!');
    }
};

$(document).ready(function () {
    fireScraper.init();
});
