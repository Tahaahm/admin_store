// ignore_for_file: unused_field, avoid_print, prefer_const_constructors, non_constant_identifier_names

import 'package:admin_store_commerce_shop/models/products/product_model.dart';
import 'package:admin_store_commerce_shop/pages/main_page/naviagte_menu.dart';
import 'package:admin_store_commerce_shop/repository/fetch_repository/fetch_repository.dart';
import 'package:admin_store_commerce_shop/repository/upload_repository/upload_repository.dart';
import 'package:admin_store_commerce_shop/util/constants/image_string.dart';
import 'package:admin_store_commerce_shop/util/constants/sizes.dart';
import 'package:admin_store_commerce_shop/util/newtork_manager/network_manager.dart';
import 'package:admin_store_commerce_shop/util/popups/full_screen_loaders.dart';
import 'package:admin_store_commerce_shop/util/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteController extends GetxController {
  static DeleteController get instance => Get.find();

  RxList<ProductModel> products = RxList<ProductModel>([]);
  final uploadRepository = Get.put(UploadRepository());
  final _productRepository = Get.put(FetchRepository());

  Future<void> fetchProductsForBrand(
      String supCategoryId, String categoryId, String brandId) async {
    try {
      List<ProductModel> productList = await _productRepository
          .fetchProductsFormBrand(supCategoryId, categoryId, brandId);
      products.assignAll(productList);
    } catch (e) {
      // Handle error
      print('Error fetching products for brand: $e');
    }
  }

  void deleteAccountWarningPopup(String supCategoryId, String categoryId,
      String brandId, String productId) {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(TSize.md),
      title: "Delete Account",
      middleText:
          "Are you sure you want to delete your account permanetly? this action is not reversible and all of your data will be removed permanently.",
      confirm: ElevatedButton(
        onPressed: () =>
            deleteProduct(supCategoryId, categoryId, brandId, productId),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: BorderSide(
            color: Colors.red,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: TSize.lg),
          child: Text("Delete"),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: Text("Cancel"),
      ),
    );
  }

  // Method to fetch and delete SupCategory
  Future<void> deleteProduct(String supCategoryId, String categoryId,
      String brandId, String productId) async {
    try {
      TFullScreenLoader.openLoadingDialog("Deleting...", TImage.processing);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
            title: "No Ineternet Connection",
            message: "Please try to connect internet and try again");
        TFullScreenLoader.stopLoadingNavigate();
        return;
      }
      // Delete SupCategory
      await uploadRepository.deleteProduct(
          supCategoryId, categoryId, brandId, productId);
      TLoaders.successSnackBar(
          title: "SupCategory deleted successfully",
          message: "Successfully deleted");
      Navigator.pushAndRemoveUntil(
          Get.context!,
          MaterialPageRoute(
            builder: (context) => NavigationMenu(),
          ),
          (route) => false);
    } catch (e) {
      TLoaders.errorSnackBar(
          title: "Failed to delete SupCategory", message: e.toString());
    }
  }
}
