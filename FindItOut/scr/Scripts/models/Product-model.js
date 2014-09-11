define([
  'underscore',
  'backbone',
  'backbone-relational'
], function (_, Backbone) {

    var ProductModel = Backbone.RelationalModel.extend({
     defaults: {
            idProduct: 0,
            active: false,
            productName: 'nuevo'
        }	
    });

    return ProductModel;

});