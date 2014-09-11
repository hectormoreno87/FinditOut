define([
  'jquery',
  'underscore',
  'backbone',
  'text!templates/form-category.html',
  'libs/jquery/jquery.blockUI'
], function ($, _, Backbone, formCategoryTemplate) {

    var FormCategoryView = Backbone.View.extend({
        //tagName: 'div',

        className: 'editCategory',

        initialize: function () {
            that = this;
            this.render = _.bind(this.render, this);
            this.model.bind('change', this.render);
            this.model.bind('destroy', this.remove);
            this.attribute = {};
        },

        attribute: {},

        events: {
            'click .save-action': 'save',
            'click .close,.close-action': 'close',
            'change input': 'modify'
        },

        template: _.template(formCategoryTemplate),

        render: function () {
            this.$el.html(this.template(this.model.toJSON()));
            return this;
        },

        show: function () {
            $(document.body).append(this.render().el);
        },

        save: function () {
            var cloneModel = this.model.clone();
            cloneModel.set(this.attribute);
            PageMethods.saveCategory(cloneModel.toJSON(), this.onCompleteSaveCategory);
            $.blockUI();
        },

        onCompleteSaveCategory: function (res) {
            that.model.set(that.attribute);
            that.model.set('idCategory', res);
            $.unblockUI();
        },

        modify: function (e) {
            this.attribute[e.currentTarget.name] = e.currentTarget.value;
        },

        close: function () {
            this.remove();
        }
    });

    return FormCategoryView;

});