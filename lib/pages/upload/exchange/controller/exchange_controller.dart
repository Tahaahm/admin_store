import 'package:admin_store_commerce_shop/pages/main_page/naviagte_menu.dart';
import 'package:admin_store_commerce_shop/util/constants/image_string.dart';
import 'package:admin_store_commerce_shop/util/newtork_manager/network_manager.dart';
import 'package:admin_store_commerce_shop/util/popups/full_screen_loaders.dart';
import 'package:admin_store_commerce_shop/util/popups/loaders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExchangeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchIQDAmount(); // Fetch the iqd_amount when the controller initializes
  }

  @override
  void onClose() {
    IQDController.clear();
    super.onClose();
  }

  static ExchangeController get instance => Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final IQDController = TextEditingController();
  final keyForm = GlobalKey<FormState>();

  // Flag to track the fetching state
  var isFetching = false.obs;

  Future<void> uploadExchangeRates() async {
    try {
      TFullScreenLoader.openLoadingDialog("Processing...", TImage.processing);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
          title: "No Internet Connection",
          message: "Please check your internet connection.",
        );
        return;
      }

      // Form Validation
      if (!keyForm.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      double iqdAmount = double.parse(IQDController.text);
      await _firestore.collection('exchange').doc('exchange_rates').set({
        'iqd_amount': iqdAmount,
      });

      TLoaders.successSnackBar(
        title: "Successfully",
        message: "Exchange rates uploaded successfully",
      );
      TFullScreenLoader.stopLoadingNavigate();
      TFullScreenLoader.stopLoadingNavigate();
    } catch (e) {
      TLoaders.errorSnackBar(
        title: "OH Snap!",
        message: "Error uploading exchange rates: $e",
      );
      TFullScreenLoader.stopLoadingNavigate();
    }
  }

  // Method to fetch the iqd_amount from Firestore
  Future<void> fetchIQDAmount() async {
    try {
      // Set the fetching flag to true
      isFetching.value = true;

      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('exchange').doc('exchange_rates').get();
      if (snapshot.exists) {
        double? iqdAmount = snapshot.data()?['iqd_amount'];
        IQDController.text = iqdAmount?.toString() ?? '';
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching iqd_amount: $e');
    } finally {
      // Set the fetching flag to false after fetching is done
      isFetching.value = false;
    }
  }
}
