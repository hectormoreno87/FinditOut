define([
  'jquery',
  'underscore',
  'backbone',
  'text!templates/app.html',
  'collections/Category-collection',
  'views/Category-view',
  'models/Category-model',
  'libs/jquery/jquery.blockUI'
], function ($, _, Backbone, appTemplate, CategoryCollection, CategoryView, CategoryModel) {

    var AppView = Backbone.View.extend({
        el: "#appContainer",

        initialize: function () {
            that = this;
            that.categories = new CategoryCollection();
            this.getCategories();
        },

        events: {
        },

        template: _.template(appTemplate),

        render: function () {
            this.$el.html(this.template());
            return this;
        },

        getCategories: function () {
            PageMethods.getCategories(hdnUser, this.onCompleteCategories);
            $.blockUI();
        },

        onCompleteCategories: function (res) {
            var collection = new CategoryCollection(res);
            that.render();
            for (var i = 0; i < collection.length; i++) {
                var catModel = collection.at(i);
                var catView = new CategoryView({ model: catModel });
                catView.render();
                that.$('#appMain').append(catView.el);
            }

            var catView = new CategoryView({ model: new CategoryModel() });
            catView.render();
            that.$('#appMain').append(catView.el);

            $.unblockUI();
        }

    });

    return AppView;

});