require.config({
    paths: {
        jquery: 'libs/jquery/jquery-min',
        underscore: 'libs/underscore/underscore',
        backbone: 'libs/backbone/backbone',
        'backbone-relational': 'libs/backbone/backbone-relational',
        templates: 'views/templates',
        'jquery-ui': 'libs/jquery/jquery-ui-min'
    }
});

define([
  'jquery',
  'underscore',
  'backbone',
  'views/app-view',
  'jquery-ui'

], function ($, _, Backbone, AppView) {
    $(function () {
        appView = new AppView();
    });   
});



