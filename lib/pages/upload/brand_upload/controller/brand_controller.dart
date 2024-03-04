// ignore_for_file: unused_field, prefer_const_constructors

import 'package:admin_store_commerce_shop/models/category/category_model.dart';
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

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  @override
  void onInit() {
    fetchCategoriesForSupCategory("");
    super.onInit();
  }

  @override
  void onClose() {
    brandTitle.clear();
    super.onClose();
  }

  final fetchRepository = Get.put(FetchRepository());
  final _uploadRepository = Get.put(UploadRepository());
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final isLoading = false.obs;
  final brandTitle = TextEditingController();

  Future<void> fetchCategoriesForSupCategory(String doc) async {
    try {
      isLoading.value = true;
      List<CategoryModel> fetchedCategories =
          await fetchRepository.fetchCategoriesForSupCategory(doc);
      categories.assignAll(fetchedCategories);
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error fetching categories for supcategory',
          message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addBrandToCategory(
      String supcategoryId, String categoryId) async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "Uploading Brands...", TImage.processing);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
            title: "No Internet Connection",
            message: "Please try to connect to the internet and try again");
        TFullScreenLoader.stopLoadingNavigate();
        return;
      }

      if (!keyForm.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (supcategoryId.isEmpty || categoryId.isEmpty) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Capitalize the first letter of the brand title
      String capitalizedBrandTitle = brandTitle.text.capitalizeFirst!;

      await _uploadRepository.addBrandToCategory(
          supcategoryId, categoryId, capitalizedBrandTitle);
      Navigator.pushAndRemoveUntil(
          Get.context!,
          MaterialPageRoute(
            builder: (context) => NavigationMenu(),
          ),
          (route) => false);
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error adding brand to category', message: e.toString());
    } finally {}
  }

  void deleteAccountWarningPopup(String supCategoryId, String categoryId) {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(TSize.md),
      title: "Delete Account",
      middleText:
          "Are you sure you want to delete your account permanetly? this action is not reversible and all of your data will be removed permanently.",
      confirm: ElevatedButton(
        onPressed: () => deleteCategory(supCategoryId, categoryId),
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

  Future<void> deleteCategory(String supCategoryId, String categoryId) async {
    try {
      TFullScreenLoader.openLoadingDialog("Deleting...", TImage.processing);
      // Delete SupCategory
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
            title: "No Ineternet Connection",
            message: "Please try to connect internet and try again");
        TFullScreenLoader.stopLoadingNavigate();
        return;
      }
      await _uploadRepository.deleteCategory(supCategoryId, categoryId);

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
