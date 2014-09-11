define([
  'jquery',
  'underscore',
  'backbone',
  'text!templates/category.html',
  'views/form-category-view',
  'views/delete-category-view',
  'views/product-view',
  'collections/product-collection',
  'models/product-model',
  'libs/jquery/jquery.blockUI'
], function ($, _, Backbone, categoryTemplate, FormCategoryView, DeleteCategoryView, ProductView, ProductCollection, ProductModel) {

    var CategoryView = Backbone.View.extend({
        tagName: 'div',

        className: 'category',

        initialize: function () {
            this.render = _.bind(this.render, this);
            this.model.bind('change', this.render);
            this.model.bind('destroy', this.remove);
        },

        events: {
            "click #btnEditCategory": "openEditDialog",
            "click #btnDeleteCategory": "openDeleteDialog"
        },

        template: _.template(categoryTemplate),

        render: function () {
            this.$el.html(this.template(this.model.toJSON()));
            var collection = new ProductCollection(this.model.get('Products'));
            for (var i = 0; i < collection.length; i++) {
                var prodModel = collection.at(i);
                var prodView = new ProductView({ model: prodModel });
                prodView.render();
                this.$('#cat_' + this.model.get('idCategory')).append(prodView.el);
            }
            if (this.model.get('idCategory') > 0) {
                var prodView = new ProductView({ model: new ProductModel() });
                prodView.render();
                this.$('#cat_' + this.model.get('idCategory')).append(prodView.el);
            }
            return this;
        },

        openEditDialog: function (e) {
            e.preventDefault();
            var formCategoryView = new FormCategoryView({ model: this.model });
            formCategoryView.show();
        },

        openDeleteDialog: function (e) {
            e.preventDefault();
            var deleteCategoryView = new DeleteCategoryView({ model: this.model });
            deleteCategoryView.show();
        }
    });

    return CategoryView;

});