define([
  'jquery',
  'underscore',
  'backbone',
  'text!templates/delete-category.html',
  'libs/jquery/jquery.blockUI'
], function ($, _, Backbone, deleteCategoryTemplate) {

    var DeleteCategoryView = Backbone.View.extend({
        //tagName: 'div',

        className: 'deleteCategory',

        initialize: function () {
            that = this;
             this.render = _.bind(this.render, this);
            this.model.bind('change', this.render);
            this.model.bind('destroy', this.remove);
        },

        attribute: {},

        events: {
            'click .delete-action': 'delete',
            'click .close,.close-action': 'close'
        },

        template: _.template(deleteCategoryTemplate),

        render: function () {
            this.$el.html(this.template(this.model.toJSON()));
            return this;
        },

        show: function () {
            $(document.body).append(this.render().el);
        },

        delete: function () {
            PageMethods.deleteCategory(this.model.get('idCategory'), this.onCompleteDeleteCategory);
            $.blockUI();
        },

        onCompleteDeleteCategory : function (res) {
            //that.model.destroy();
            that.remove();
            $.unblockUI();
        },

        close: function () {
            this.remove();
        }
    });

    return DeleteCategoryView;

});