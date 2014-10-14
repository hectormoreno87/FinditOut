define([
  'jquery',
  'underscore',
  'backbone',
  'text!templates/form-category.html',
  'libs/jquery/jquery.blockUI',
  'libs/backbone/backbone-validator'
], function ($, _, Backbone, formCategoryTemplate) {

    var FormCategoryView = Backbone.View.extend({
        //tagName: 'div',

        className: 'editCategory',

        initialize: function () {
            that = this;
            _.bindAll(this, 'render', 'remove');
            this.model.bind('change', this.render);
            this.model.bind('destroy', this.remove);
            this.bindValidation();
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
            this.model.set(this.attribute, { validate: true });
            if (cloneModel.isValid()) {
                PageMethods.saveCategory(hdnUser, cloneModel.toJSON(), this.onCompleteSaveCategory);
                $.blockUI();
            } 
        },

        onCompleteSaveCategory: function (res) {
            var added = false;
            if (that.model.get('idCategory') === 0) {
                added = true;
            }
            that.model.set(that.attribute);
            if (added) {
                that.model.set('idCategory', res);
                that.model.set('Products', []);
                appView.categories.push(that.model.toJSON());
                appView.render();
            }
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