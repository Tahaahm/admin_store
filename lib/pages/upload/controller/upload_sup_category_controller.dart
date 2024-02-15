// ignore_for_file: prefer_const_constructors, unused_field, unused_local_variable, use_rethrow_when_possible, avoid_print

import 'package:admin_store_commerce_shop/pages/main_page/naviagte_menu.dart';
import 'package:admin_store_commerce_shop/repository/upload_repository/upload_repository.dart';
import 'package:admin_store_commerce_shop/util/constants/image_string.dart';
import 'package:admin_store_commerce_shop/util/newtork_manager/network_manager.dart';
import 'package:admin_store_commerce_shop/util/popups/full_screen_loaders.dart';
import 'package:admin_store_commerce_shop/util/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadSupCategories extends GetxController {
  @override
  void onClose() {
    titleCategory.clear();
    super.onClose();
  }

  static UploadSupCategories get instance => Get.find();

  final uploadRepository = Get.put(UploadRepository());

  final titleCategory = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final UploadRepository _repository = UploadRepository();

  Future<void> uploadSupercategory() async {
    try {
      TFullScreenLoader.openLoadingDialog("Uploading...", TImage.processing);

      if (!keyForm.currentState!.validate()) {
        return;
      }
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
            title: "No Ineternet Connection",
            message: "Please try to connect internet and try again");
        TFullScreenLoader.stopLoadingNavigate();
        return;
      }
      await _repository.createSupcategory(titleCategory.text);
      TLoaders.successSnackBar(
          title: "Upload Category Successfully",
          message: "There is new category now");
      Navigator.pushAndRemoveUntil(
          Get.context!,
          MaterialPageRoute(
            builder: (context) => NavigationMenu(),
          ),
          (route) => false);
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}
