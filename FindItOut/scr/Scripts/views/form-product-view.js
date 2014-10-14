define([
  'jquery',
  'underscore',
  'backbone',
  'text!templates/form-product.html',
  'jquery.form',
  'libs/jquery/jquery.blockUI',
  'libs/backbone/backbone-validator'
], function ($, _, Backbone, formProductTemplate) {

    var FormProductView = Backbone.View.extend({
        //tagName: 'div',

        className: 'editProduct',

        initialize: function () {
            that = this;
            //this.render = _.bind(this.render, this);
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
            'change input': 'modify',
            'change #photoimg': 'fileSelected',
            'click .imgThumbnail': 'imgClicked'
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
            this.model.set(this.attribute, { validate: true });
            var idCategory = cloneModel.get('idCategory');
            if (cloneModel.isValid()) {
                PageMethods.saveProduct(hdnUser, idCategory, cloneModel.toJSON(), this.onCompleteSaveProduct);
                $.blockUI();
            }
        },

        onCompleteSaveProduct: function (res) {
            var added = false;
            //if (that.model.get('idProduct') === 0) {
            //    added = true;
            //}
            that.model.set(that.attribute);
            that.model.set('idProduct', res);
            //if (added) {
            //    appView.categories.where({ idCategory: that.model.get('idCategory') })[0].get('Products').push(that.model.toJSON());
            //}
            //appView.categories.where({ idCategory: that.model.get('idCategory') })[0].trigger('change');
            appView.getCategories();
            $.unblockUI();
        },

        modify: function (e) {
            this.attribute[e.currentTarget.name] = e.currentTarget.value;
        },

        fileSelected: function () {
            var A = $("#imageloadstatus");
            var B = $("#imageloadbutton");

            var modelJSON = this.model.toJSON();
            var model = this.model;
            $("#imageform").ajaxForm({
                target: '#preview',
                dataType: 'json',
                data: modelJSON,
                beforeSubmit: function () {
                    A.show();
                    B.hide();
                },
                success: function (res) {
                    A.hide();
                    B.show();
                    if (res.success) {
                        var modelAux = model;
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

        imgClicked: function (e) {
            var idUser = hdnUser;
            var idProduct = this.model.get('idProduct');
            var idImage = $(e.target).attr('data-id');
            PageMethods.deleteImage(idUser, idProduct, idImage, this.onCompleteDeleteImage);
        },

        onCompleteDeleteImage: function (resStr) {
            var res = $.parseJSON(resStr);
            if (res.success) {
                var modelAux = that.model;
                var images = modelAux.get('ProductImages');
                if (!images) {
                    images = new Array();
                }
                var imgToRem;
                $.each(images, function (index, value) {
                    if (value.idImage == res.idImage) {
                        imgToRem = index;
                    }
                });
                images.splice(imgToRem, 1);

                modelAux.set('ProductImages', images);
                modelAux.trigger('change');
            }
        },

        close: function () {
            this.remove();
        }
    });

    return FormProductView;

});