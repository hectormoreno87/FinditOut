define([
  'underscore',
  'backbone',
  'backbone-relational',
  'libs/backbone/backbone-validator'
], function (_, Backbone) {

    var ProductModel = Backbone.RelationalModel.extend({

        defaults: {
            idProduct: 0,
            active: false,
            blocked: false,
            productName: 'nuevo',
            description: '',
            price: 0.0

        },
        validation: {
            productName: {
                required: true,
                maxLength: 100,
                message: 'Name is required'
            },
            description: {
                maxLength: 150
            },
            price: {
                format: 'digits'
            }
        },
        clear: function () {
            this.destroy();
        }
    });

    return ProductModel;

});