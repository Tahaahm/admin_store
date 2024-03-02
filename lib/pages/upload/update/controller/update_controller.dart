// ignore_for_file: unused_local_variable, unnecessary_this

import 'package:admin_store_commerce_shop/pages/main_page/naviagte_menu.dart';
import 'package:admin_store_commerce_shop/repository/upload_repository/upload_repository.dart';
import 'package:admin_store_commerce_shop/util/constants/image_string.dart';
import 'package:admin_store_commerce_shop/util/newtork_manager/network_manager.dart';
import 'package:admin_store_commerce_shop/util/popups/full_screen_loaders.dart';
import 'package:admin_store_commerce_shop/util/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_store_commerce_shop/models/products/product_model.dart';

class UpdateController extends GetxController {
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

  static UpdateController get instance => Get.find();

  // Declare variables to hold product data
  late ProductModel _product;

  final currencyList = ['USD', 'IQD'];

  late TextEditingController nameProductController;
  late TextEditingController depthController;
  late TextEditingController widthController;
  late TextEditingController heightController;
  late TextEditingController volumeController;
  late TextEditingController powerController;
  late TextEditingController priceController;
  late TextEditingController materialController;
  late TextEditingController brandController;
  late TextEditingController stockController;
  late TextEditingController descriptionController; // Fixed variable name
  late TextEditingController weightController;
  late String newCurrency;
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  // Getter to access product data
  ProductModel get product => _product;

  // Constructor to receive product data
  UpdateController({required ProductModel product}) {
    _product = product;

    nameProductController = TextEditingController(text: product.title);
    depthController = TextEditingController(text: product.depth.toString());
    widthController = TextEditingController(text: product.width.toString());
    heightController = TextEditingController(text: product.height.toString());
    priceController = TextEditingController(text: product.price.toString());
    volumeController = TextEditingController(text: product.volume.toString());
    powerController = TextEditingController(text: product.power.toString());
    stockController = TextEditingController(text: product.stock.toString());
    materialController = TextEditingController(text: product.material);
    brandController = TextEditingController(text: product.brand.toString());
    weightController = TextEditingController(
        text: product.weight.toString()); // Fixed variable name
    newCurrency = product.currency;

    // Join the list of descriptions into a single string
    descriptionController =
        TextEditingController(text: product.description.join(', '));
  }

  Future<void> updateProduct(String supcategoryId, String category,
      String brandId, String productId) async {
    try {
      TFullScreenLoader.openLoadingDialog("Updating...", TImage.processing);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
            title: "No Ineternet Connection",
            message: "Please try to connect internet and try again");
        TFullScreenLoader.stopLoadingNavigate();
        return;
      }
      if (!keyForm.currentState!.validate()) {
        TLoaders.errorSnackBar(
            title: "No internet connection",
            message: "Please connect to the enternet first");
        Navigator.of(Get.context!).pop();
        return;
      }
      String updatedTitle = _capitalizeFirstLetter(nameProductController.text);

      ProductModel newProduct = ProductModel(
        id: product.id,
        title: updatedTitle,
        depth: double.parse(depthController.text),
        width: double.parse(widthController.text),
        height: double.parse(heightController.text),
        power: double.parse(powerController.text),
        price: double.parse(priceController.text),
        currency: newCurrency, // Use the updated currency value
        material: materialController.text,
        imageUrl: product.imageUrl,
        brand: brandController.text,
        stock: int.parse(stockController.text),
        description: descriptionController.text.split(','),
        volume: double.parse(volumeController.text),
        weight: double.parse(weightController.text),
        supcategoryId: supcategoryId, categoryId: category, brandId: brandId,
      );

      await UploadRepository.instance.updateProduct(
          supcategoryId, category, brandId, productId, newProduct);

      // Handle success or notify the user
      TLoaders.successSnackBar(
          title: "Product updated successfully!",
          message: "The Product has been updated!!!");
      Navigator.pushAndRemoveUntil(
        Get.context!,
        MaterialPageRoute(
          builder: (context) => NavigationMenu(),
        ),
        (route) => false,
      );
    } catch (e) {
      TLoaders.errorSnackBar(
          title: "Error updating product", message: e.toString());
    }
  }

  void updateTextController(TextEditingController controller, String newText) {
    controller.text = newText;
  }

  void updateNewCurrency(String newCurrency) {
    this.newCurrency = newCurrency;
  }

  // Method to update the corresponding text field controller based on the currency selected
  void updateTextControllerDropDown(String newValue) {
    // Update the new currency value
    updateNewCurrency(newValue);

    // Update the current currency value in the controller
    newCurrency = newValue;
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1);
  }
}
