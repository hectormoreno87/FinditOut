define([
  'jquery',
  'underscore',
  'backbone',
  'text!templates/form-product.html',
  'jquery.form',
  'libs/jquery/jquery.blockUI'
], function ($, _, Backbone, formProductTemplate) {

    var FormProductView = Backbone.View.extend({
        //tagName: 'div',

        className: 'editProduct',

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
            'change input': 'modify',
            'change #photoimg': 'fileSelected'
        },

        template: _.template(formProductTemplate),

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
            var idCategory = cloneModel.get('idCategory');
            PageMethods.saveProduct(hdnUser, idCategory, cloneModel.toJSON(), this.onCompleteSaveProduct);
            $.blockUI();
        },

        onCompleteSaveProduct: function (res) {
            that.model.set(that.attribute);
            that.model.set('idProduct', res);
            $.unblockUI();
        },

        modify: function (e) {
            this.attribute[e.currentTarget.name] = e.currentTarget.value;
        },

        fileSelected: function () {
            var A = $("#imageloadstatus");
            var B = $("#imageloadbutton");

            var model = this.model.toJSON();
            $("#imageform").ajaxForm({
                target: '#preview',
                dataType: 'json',
                data: model,
                beforeSubmit: function () {
                    A.show();
                    B.hide();
                },
                success: function (res) {
                    A.hide();
                    B.show();
                    if (res.success) {
                        var modelAux = that.model;
                        var images = modelAux.get('ProductImages');
                        if (!images) {
                            images = new Array();
                        }
                        images.push(res.attr);
                        modelAux.set('ProductImages', images);
                        modelAux.trigger('change');
                    }
                },
                error: function (xhr, status, error) {
                    A.hide();
                    B.show();
                    alert('se cago');
                }
            }).submit();
        },

        close: function () {
            this.remove();
        }
    });

    return FormProductView;

});