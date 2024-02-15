// ignore_for_file: avoid_print

import 'package:admin_store_commerce_shop/models/brand/brand.dart';
import 'package:admin_store_commerce_shop/models/category/category_model.dart';
import 'package:admin_store_commerce_shop/models/products/product_model.dart';
import 'package:admin_store_commerce_shop/models/sup_category/sup_category.dart';
import 'package:admin_store_commerce_shop/util/popups/loaders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FetchRepository extends GetxController {
  static FetchRepository get instance => Get.find();
  //
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //fetch SupCategory
  Future<List<SupCategoryModel>> fetchSupcategories() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Supcategories').get();

      return snapshot.docs
          .map((doc) => SupCategoryModel.fromFirestore(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw TLoaders.errorSnackBar(title: e.toString());
    } on FormatException catch (e) {
      throw TLoaders.errorSnackBar(title: e.toString());
    } on PlatformException catch (e) {
      throw TLoaders.errorSnackBar(title: e.toString());
    } catch (e) {
      throw "Something went wrong.Please try agian";
    }
  }

//fetch category and supcategory for brands
  Future<List<CategoryModel>> fetchCategoriesForSupCategory(
      String supCategoryId) async {
    try {
      QuerySnapshot categoriesSnapshot = await _firestore
          .collection('Supcategories')
          .doc(supCategoryId)
          .collection('categories')
          .get();
      List<CategoryModel> categories = categoriesSnapshot.docs.map((doc) {
        return CategoryModel(
          id: doc.id,
          title: doc['title'],
          imageUrl: doc['imageUrl'],
        );
      }).toList();
      return categories;
    } catch (e) {
      print('Error fetching categories for supcategory: $e');
      return [];
    }
  }

  Future<List<BrandModel>> fetchBrandsForCategory(
      String supCategoryId, String categoryId) async {
    try {
      QuerySnapshot brandsSnapshot = await _firestore
          .collection('Supcategories')
          .doc(supCategoryId)
          .collection('categories')
          .doc(categoryId)
          .collection('brands')
          .get();
      List<BrandModel> brands = brandsSnapshot.docs.map((doc) {
        return BrandModel.fromFirestore(doc);
      }).toList();
      return brands;
    } catch (e) {
      print('Error fetching brands for category: $e');
      return [];
    }
  }

  Future<List<ProductModel>> fetchProductsFormBrand(
      String supCategoryId, String categoryId, String brandId) async {
    try {
      QuerySnapshot productSnapshot = await _firestore
          .collection('Supcategories')
          .doc(supCategoryId)
          .collection('categories')
          .doc(categoryId)
          .collection('brands')
          .doc(brandId)
          .collection('products')
          .get();
      List<ProductModel> products = productSnapshot.docs.map((doc) {
        return ProductModel.fromFirestore(doc);
      }).toList();

      return products;
    } catch (e) {
      print('Error fetching products for brand: $e');
      return [];
    }
  }
}
