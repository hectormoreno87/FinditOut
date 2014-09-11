define([
  'underscore',
  'backbone',
  'models/product-model',
  'collections/product-collection',
  'backbone-relational'

], function (_, Backbone, ProductModel, ProductCollection) {

    var CategoryModel = Backbone.RelationalModel.extend({

        defaults: {
            idCategory: 0,
            active: false,
            categoryName: 'nueva'
        },

        relations: [{
            type: Backbone.HasMany,
            key: 'Products',
            relatedModel: CategoryModel,
            collectionType: ProductCollection,
            reverseRelation: {
                key: 'Category',
                includeInJSON: false
            }
        }]
    });

    return CategoryModel;

});
