// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print, non_constant_identifier_names

import 'dart:io';

import 'package:admin_store_commerce_shop/models/sup_category/sup_category.dart';
import 'package:admin_store_commerce_shop/pages/main_page/naviagte_menu.dart';
import 'package:admin_store_commerce_shop/repository/fetch_repository/fetch_repository.dart';
import 'package:admin_store_commerce_shop/repository/services/t_firebase_storage_service.dart';
import 'package:admin_store_commerce_shop/repository/upload_repository/upload_repository.dart';
import 'package:admin_store_commerce_shop/util/constants/image_string.dart';
import 'package:admin_store_commerce_shop/util/constants/sizes.dart';
import 'package:admin_store_commerce_shop/util/newtork_manager/network_manager.dart';
import 'package:admin_store_commerce_shop/util/popups/full_screen_loaders.dart';
import 'package:admin_store_commerce_shop/util/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadCategoriesController extends GetxController {
  static UploadCategoriesController get instance => Get.find();

  List<SupCategoryModel> supcategories = <SupCategoryModel>[].obs;
  @override
  void onInit() {
    fetchSupcategories();
    super.onInit();
  }

  @override
  void onClose() {
    categoryName.clear();
    super.onClose();
  }

  final uploadRepository = Get.put(UploadRepository());
  final fetchRepository = Get.put(FetchRepository());
  final isLoading = false.obs;
  final categoryName = TextEditingController();
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final TFirebaseStorageService _storageService = TFirebaseStorageService();
  Rx<File?> pickedImage = Rx<File?>(null); // Rx variable for the picked image
  final ImagePicker _picker = ImagePicker();

  //fetch SupCategory
  Future<List<SupCategoryModel>> fetchSupcategories() async {
    try {
      isLoading.value = true;
      supcategories = await fetchRepository.fetchSupcategories();

      return supcategories;
    } catch (e) {
      // Handle errors
      TLoaders.errorSnackBar(
          title: "Error fetching supcategories", message: e.toString());
      // Optionally, you can rethrow the error to handle it in the UI layer
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createCategory(String supcategoryId) async {
    try {
      // Open loading dialog
      TFullScreenLoader.openLoadingDialog(
          "Uploading Category...", TImage.processing);

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

      // Check if pickedImage is null
      if (pickedImage.value == null) {
        TLoaders.errorSnackBar(
            title: "Oh Snap!", message: "Please select an image!!!");
        TFullScreenLoader.stopLoadingNavigate();
        print("object");
        return;
      }
      if (supcategoryId.isEmpty) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Capitalize the first letter of the category name
      String capitalizedCategoryName = categoryName.text.capitalizeFirst!;

      final imageUrl = await _storageService.uploadImageFile(
          'Categories', pickedImage.value!, capitalizedCategoryName);

      // Create category in Firestore
      await uploadRepository.createCategory(
          supcategoryId, capitalizedCategoryName, imageUrl);
      TLoaders.successSnackBar(
          title: "Successfully adding Category",
          message: "There is new Category");
      // Close loading dialog

      // Navigate back to the previous page after successful upload
      Navigator.pushAndRemoveUntil(
          Get.context!,
          MaterialPageRoute(
            builder: (context) => NavigationMenu(),
          ),
          (route) => false);
    } catch (e) {
      // Handle errors
      print("Error creating category: $e");
      TLoaders.errorSnackBar(
          title: 'Error creating category', message: e.toString());
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage.value = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  Future<void> deletePickedImage() async {
    try {
      // Check if the picked image exists
      if (pickedImage.value != null && await pickedImage.value!.exists()) {
        // Delete the picked image file
        await pickedImage.value!.delete();
        print('Picked image deleted successfully');
        pickedImage.value = null; // Reset pickedImage to null
      } else {
        print('Picked image does not exist');
      }
    } catch (e) {
      // Handle any errors
      print('Error deleting picked image: $e');
    }
  }

  void deleteAccountWarningPopup(String supCategoryId) {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(TSize.md),
      title: "Delete Account",
      middleText:
          "Are you sure you want to delete your account permanetly? this action is not reversible and all of your data will be removed permanently.",
      confirm: ElevatedButton(
        onPressed: () => DeleteSupCategory(supCategoryId),
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
  Future<void> DeleteSupCategory(String supCategoryId) async {
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
      await uploadRepository.deleteSupCategory(supCategoryId);
      await fetchSupcategories();
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
