define([
  'underscore',
  'backbone',
  'models/Product-model'
], function (_, Backbone, ProductModel) {

    var ProductCollection = Backbone.Collection.extend({

        model: ProductModel,

        initialize: function (models, options) { }

    });

    return ProductCollection;

});