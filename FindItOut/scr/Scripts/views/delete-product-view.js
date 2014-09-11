define([
  'jquery',
  'underscore',
  'backbone',
  'text!templates/delete-product.html',
  'libs/jquery/jquery.blockUI'
], function ($, _, Backbone, deleteProductTemplate) {

    var DeleteProductView = Backbone.View.extend({
        //tagName: 'div',

        className: 'deleteProduct',

        initialize: function () {
            that = this;
             this.render = _.bind(this.render, this);
            this.model.bind('change', this.render);
            this.model.bind('destroy', this.remove);
        },

        attribute : {},

        events: {
            'click .delete-action': 'delete',
            'click .close,.close-action': 'close'
        },

        template: _.template(deleteProductTemplate),

        render: function () {
            this.$el.html(this.template(this.model.toJSON()));
            return this;
        },

        show: function () {
            $(document.body).append(this.render().el);
        },

        delete: function () {
            PageMethods.deleteProduct(this.model.get('idProduct'), this.onCompleteDeleteProduct);
            $.blockUI();
        },

        onCompleteDeleteProduct: function (res) {
            //that.model.destroy();
            that.remove();
            $.unblockUI();
        },

        close: function () {
            this.remove();
        }
    });

    return DeleteProductView;

});