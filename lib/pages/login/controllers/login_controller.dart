// ignore_for_file: unused_local_variable, unnecessary_overrides
import 'package:admin_store_commerce_shop/models/user_model.dart';
import 'package:admin_store_commerce_shop/repository/authentication_repository.dart';
import 'package:admin_store_commerce_shop/repository/user_repository/user.dart';
import 'package:admin_store_commerce_shop/util/constants/image_string.dart';
import 'package:admin_store_commerce_shop/util/newtork_manager/network_manager.dart';
import 'package:admin_store_commerce_shop/util/popups/full_screen_loaders.dart';
import 'package:admin_store_commerce_shop/util/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  LoginController get instance => Get.find();
  @override
  void onInit() {
    super.onInit();
  }

  Rx<UserModel> user = UserModel.empty().obs;
  final email = TextEditingController();
  final password = TextEditingController();
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  GlobalKey<FormState> loginFromKey = GlobalKey<FormState>();
  final localStorage = GetStorage();
  final profileLoading = false.obs;
  Future<void> emailAndPasswordSignIn() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "Logging you in....", TImage.processing);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
            title: "No Ineternet Connection",
            message: "Please try to connect internet and try again");
        TFullScreenLoader.stopLoadingNavigate();
        return;
      }
      if (!loginFromKey.currentState!.validate()) {
        TFullScreenLoader.stopLoadingNavigate();
        return;
      }

      final userCredential = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      TFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.ScreenRedirct();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap!!", message: e.toString());
    }
  }

  Future<void> fetchUserRecrod() async {
    try {
      profileLoading.value = true;
      final user = await UserRepository.instance.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }
}
