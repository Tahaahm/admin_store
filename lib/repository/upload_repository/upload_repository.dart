// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, unused_field, avoid_returning_null_for_void, unused_local_variable, body_might_complete_normally_nullable, avoid_function_literals_in_foreach_calls, unnecessary_string_interpolations, avoid_print

import 'package:admin_store_commerce_shop/models/products/product_model.dart';
import 'package:admin_store_commerce_shop/util/popups/loaders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

class UploadRepository extends GetxController {
  static UploadRepository get instance => Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//upload SupCategory
  Future<DocumentReference> createSupcategory(String title) async {
    try {
      final CollectionReference supcategoriesCollection =
          FirebaseFirestore.instance.collection('Supcategories');

      return await supcategoriesCollection.add({'title': '$title'});
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

  Future<DocumentReference> createCategory(
      String? supcategoryId, String title, String imageUrl) async {
    try {
      if (supcategoryId == null) {
        TLoaders.errorSnackBar(title: "Supcategory ID cannot be null");
      }

      final CollectionReference categoriesCollection = FirebaseFirestore
          .instance
          .collection('Supcategories')
          .doc(supcategoryId)
          .collection('categories');
      return await categoriesCollection.add({
        'title': title,
        'imageUrl': imageUrl,
      });
    } catch (e) {
      throw "Error creating category: $e";
    }
  }

  Future<DocumentReference> addBrandToCategory(
      String? supcategoryId, String? categoryId, String brandTitle) async {
    try {
      if (supcategoryId == null || categoryId == null) {
        TLoaders.errorSnackBar(
            title: "Oh Snap!!",
            message: "Supcategory ID and Category ID cannot be null");
      }

      final CollectionReference brandsCollection = _firestore
          .collection('Supcategories')
          .doc(supcategoryId)
          .collection('categories')
          .doc(categoryId)
          .collection('brands');
      TLoaders.successSnackBar(
          title: "Successfully added new Brand",
          message: "Now you can check new brand");

      return await brandsCollection.add({'title': brandTitle});
    } catch (e) {
      throw 'Error adding brand to category: $e';
    }
  }

  Future<void> uploadProductInBrand(String supCategoryId, String categoryId,
      String brandId, ProductModel product) async {
    try {
      print(supCategoryId);
      print(categoryId);
      print(brandId);
      await _firestore
          .collection('Supcategories')
          .doc(supCategoryId)
          .collection('categories')
          .doc(categoryId)
          .collection('brands')
          .doc(brandId)
          .collection('products')
          .add(product.toJson());
    } catch (e) {
      TLoaders.successSnackBar(
          title: "Oh Snap!!", message: "Error uploading product: $e");
      // Handle error
    }
  }

  //delete
  Future<void> deleteSupCategory(String supCategoryId) async {
    try {
      await _firestore.collection('Supcategories').doc(supCategoryId).delete();
      await _deleteSubcollections('Supcategories/$supCategoryId');
    } catch (e) {
      print('Error deleting SupCategory: $e');
    }
  }

  Future<void> _deleteSubcollections(String path) async {
    QuerySnapshot snapshot = await _firestore.collectionGroup(path).get();
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
      await _deleteSubcollections('$path/${doc.id}');
    }
  }

  Future<void> deleteCategory(String supCategoryId, String categoryId) async {
    try {
      await _firestore
          .collection('Supcategories')
          .doc(supCategoryId)
          .collection('categories')
          .doc(categoryId)
          .delete();
    } catch (e) {
      print('Error deleting category: $e');
    }
  }

  Future<void> deleteBrand(
      String supCategoryId, String categoryId, String brandId) async {
    try {
      await _firestore
          .collection('Supcategories')
          .doc(supCategoryId)
          .collection('categories')
          .doc(categoryId)
          .collection('brands')
          .doc(brandId)
          .delete();
    } catch (e) {
      print('Error deleting brand: $e');
    }
  }

  Future<void> deleteProduct(String supCategoryId, String categoryId,
      String brandId, String productId) async {
    try {
      await _firestore
          .collection('Supcategories')
          .doc(supCategoryId)
          .collection('categories')
          .doc(categoryId)
          .collection('brands')
          .doc(brandId)
          .collection('products')
          .doc(productId)
          .delete();
    } catch (e) {
      print('Error deleting brand: $e');
    }
  }

  Future<void> updateProduct(
    String supCategoryId,
    String categoryId,
    String brandId,
    String productId,
    ProductModel updatedProduct,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('Supcategories')
          .doc(supCategoryId)
          .collection('categories')
          .doc(categoryId)
          .collection('brands')
          .doc(brandId)
          .collection('products')
          .doc(productId)
          .update(updatedProduct.toMap());
    } catch (e) {
      print('Error updating product: $e');
    }
  }
}
