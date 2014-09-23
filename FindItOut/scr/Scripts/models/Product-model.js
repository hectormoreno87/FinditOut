define([
  'underscore',
  'backbone',
  'backbone-relational'
], function (_, Backbone) {

    var ProductModel = Backbone.RelationalModel.extend({
     defaults: {
            idProduct: 0,
            active: false,
            locked: false,
            productName: 'nuevo',
            description: '',
            price: 0.0
                        
        }	
    });

    return ProductModel;

});