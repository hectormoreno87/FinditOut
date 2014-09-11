define([
  'underscore',
  'backbone',
  'models/Category-model'
], function (_, Backbone, CategoryModel) {

    var CategoryCollection = Backbone.Collection.extend({

        model: CategoryModel,

        initialize: function (models, options) { }

    });

    return CategoryCollection;

});