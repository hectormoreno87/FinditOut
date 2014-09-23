define([
  'jquery',
  'underscore',
  'backbone',
  'text!templates/product.html',
  'views/form-product-view',
  'views/delete-product-view',
  'libs/jquery/jquery.blockUI'
], function ($, _, Backbone, productTemplate, FormProductView, DeleteProductView) {

    var ProductView = Backbone.View.extend({
        tagName: 'div',

        className: 'product',

        initialize: function () {
            this.render = _.bind(this.render, this);
            this.model.bind('change', this.render);
            this.model.bind('destroy', this.remove);
        },

        events: {
            "click #btnEditProduct": "openEditDialog",
            "click #btnDeleteProduct": "openDeleteDialog"
        },

        template: _.template(productTemplate),

        render: function () {
            this.$el.html(this.template(this.model.toJSON()));
          
            return this;
        },

        openEditDialog: function (e) {
            e.preventDefault();
            var formProductView = new FormProductView({ model: this.model });
            formProductView.show();

        },
        openDeleteDialog: function (e) {
            e.preventDefault();
            var deleteProductView = new DeleteProductView({ model: this.model });
            deleteProductView.show();

        }
    });

    return ProductView;

});