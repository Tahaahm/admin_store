// ignore_for_file: unused_field, avoid_print, prefer_const_constructors

import 'dart:io';
import 'dart:math';

import 'package:admin_store_commerce_shop/models/brand/brand.dart';
import 'package:admin_store_commerce_shop/models/products/product_model.dart';
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

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final _fetchRepository = Get.put(FetchRepository());
  final _uploadRepository = Get.put(UploadRepository());
  RxList<BrandModel> brands = <BrandModel>[].obs;
  final descriptions = <RxString>[].obs;
  final selectedCurrency = RxString('USD');
  final currencyList = ['USD', 'IQD'];

  final nameProductController = TextEditingController();
  final depthController = TextEditingController();
  final widthController = TextEditingController();
  final heightController = TextEditingController();
  final volumeController = TextEditingController();
  final powerController = TextEditingController();
  final priceController = TextEditingController();
  final materialController = TextEditingController();
  final brandController = TextEditingController();
  final stockController = TextEditingController();
  final descriptionController = TextEditingController(); // Fixed variable name
  final weightController = TextEditingController(); // Fixed variable name

  final isLoading = false.obs;
  final uploadRepository = Get.put(UploadRepository());
  final fetchRepository = Get.put(FetchRepository());
  final categoryName = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final TFirebaseStorageService _storageService = TFirebaseStorageService();
  Rx<File?> pickedImage = Rx<File?>(null); // Rx variable for the picked image
  final ImagePicker _picker = ImagePicker();

  @override
  void onClose() {
    nameProductController.clear();
    depthController.clear();
    widthController.clear();
    heightController.clear();
    volumeController.clear();
    powerController.clear();
    priceController.clear();
    materialController.clear();
    brandController.clear();
    stockController.clear();
    descriptionController.clear();
    weightController.clear();

    super.onClose();
  }

  Future<void> fetchBrandInCategories(
      String supCategoryId, String categoryId) async {
    try {
      isLoading.value = true;
      List<BrandModel> fetchedBrands = await _fetchRepository
          .fetchBrandsForCategory(supCategoryId, categoryId);
      brands.assignAll(fetchedBrands);
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error fetching categories for supcategory',
          message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> uploadProductToBrand({
    required String supCategoryId,
    required String categoryId,
    required String brandId,
  }) async {
    try {
      // Open loading dialog
      TFullScreenLoader.openLoadingDialog(
        "Uploading Product...",
        TImage.processing,
      );

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

      if (supCategoryId.isEmpty || categoryId.isEmpty || brandId.isEmpty) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Check if pickedImage is null
      if (pickedImage.value == null) {
        TLoaders.errorSnackBar(
          title: "Oh Snap!",
          message: "Please select an image!!!",
        );
        TFullScreenLoader.stopLoadingNavigate();
        return;
      }

      final imageUrl = await _storageService.uploadImageFile(
        'Products',
        pickedImage.value!,
        _capitalizeFirstLetter(nameProductController.text),
      );

      var random = Random().nextInt(10000);
      // Set the image URL in the product model
      final product = ProductModel(
        id: random.toString(),
        title: _capitalizeFirstLetter(nameProductController.text),
        depth: double.parse(depthController.text),
        width: double.parse(widthController.text),
        height: double.parse(heightController.text),
        power: double.parse(powerController.text),
        price: double.parse(priceController.text),
        currency: selectedCurrency.toString(),
        material: materialController.text,
        imageUrl: imageUrl,
        brand: brandController.text,
        stock: int.parse(stockController.text),
        description: descriptions.map((desc) => desc.value).toList(),
        volume: double.parse(volumeController.text),
        weight: double.parse(weightController.text),
        supcategoryId: supCategoryId,
        categoryId: categoryId,
        brandId: brandId,
      );

      // Upload the product to the brand
      await uploadRepository.uploadProductInBrand(
        supCategoryId,
        categoryId,
        brandId,
        product,
      );

      // Close loading dialog
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: "Successfully added new Product",
          message: "Now you can check new Product");
      Navigator.pushAndRemoveUntil(
        Get.context!,
        MaterialPageRoute(
          builder: (context) => NavigationMenu(),
        ),
        (route) => false,
      );
    } catch (e) {
      // Handle errors
      print("Error uploading product: $e");
      TLoaders.errorSnackBar(
        title: 'Error uploading product',
        message: e.toString(),
      );
    }
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1);
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage.value = File(pickedFile.path);
    } else {
      TLoaders.warningSnackBar(title: "print('No image selected");
    }
  }

  Future<void> deletePickedImage() async {
    try {
      // Check if the picked image exists
      if (pickedImage.value != null && await pickedImage.value!.exists()) {
        // Delete the picked image file
        await pickedImage.value!.delete();
        TLoaders.successSnackBar(title: "Picked image deleted successfully");
        pickedImage.value = null; // Reset pickedImage to null
      } else {
        TLoaders.warningSnackBar(title: "Picked image does not exist");
      }
    } catch (e) {
      // Handle any errors
      print('Error deleting picked image: $e');
    }
  }

  void addDescription() {
    descriptions.add(RxString(""));
  }

  void deleteAccountWarningPopup(
      String supCategoryId, String categoryId, brandId) {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(TSize.md),
      title: "Delete Account",
      middleText:
          "Are you sure you want to delete your account permanetly? this action is not reversible and all of your data will be removed permanently.",
      confirm: ElevatedButton(
        onPressed: () => deleteBrand(supCategoryId, categoryId, brandId),
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
  Future<void> deleteBrand(
      String supCategoryId, String categoryId, brandId) async {
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
      await uploadRepository.deleteBrand(supCategoryId, categoryId, brandId);

      TLoaders.successSnackBar(
          title: "Brand deleted successfully", message: "Successfully deleted");
      Navigator.pushAndRemoveUntil(
          Get.context!,
          MaterialPageRoute(
            builder: (context) => NavigationMenu(),
          ),
          (route) => false);
    } catch (e) {
      TLoaders.errorSnackBar(
          title: "Failed to delete Brand", message: e.toString());
    }
  }
}
