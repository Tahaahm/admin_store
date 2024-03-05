// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:admin_store_commerce_shop/models/user_model.dart';
import 'package:admin_store_commerce_shop/repository/user_repository/user.dart';
import 'package:admin_store_commerce_shop/util/constants/sizes.dart';
import 'package:admin_store_commerce_shop/util/newtork_manager/network_manager.dart';
import 'package:admin_store_commerce_shop/util/popups/full_screen_loaders.dart';
import 'package:admin_store_commerce_shop/util/popups/loaders.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final usersLoading = false.obs;
  RxList<UserModel> userList = <UserModel>[].obs;

  Timer? _timer;

  @override
  void onInit() {
    fetchAllUsers(); // Initially fetch users
    startFetchingUsersPeriodically();
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel(); // Cancel the timer when the controller is closed
    super.onClose();
  }

  Future<void> fetchAllUsers() async {
    try {
      usersLoading.value = true;
      final users = await UserRepository.instance.fetchAllUsers();
      userList.assignAll(users);
    } catch (e) {
      // Handle error
    } finally {
      usersLoading.value = false;
    }
  }

  void startFetchingUsersPeriodically() {
    const duration = Duration(seconds: 300);
    _timer = Timer.periodic(duration, (timer) {
      fetchAllUsers();
    });
  }

  void deleteAccountWarningPopup(String userId, String email) {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(TSize.md),
      title: "Delete Account",
      middleText:
          "Are you sure you want to delete your account permanetly? this action is not reversible and all of your data will be removed permanently.",
      confirm: ElevatedButton(
        onPressed: () => deleteUser(userId, email),
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

  Future<void> deleteUser(String userId, String email) async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
            title: "No Ineternet Connection",
            message: "Please try to connect internet and try again");
        TFullScreenLoader.stopLoadingNavigate();
        return;
      }

      await UserRepository.instance.removeUserRecord(userId, email);

      userList.removeWhere((user) => user.id == userId);
      TLoaders.successSnackBar(title: "Successfully Delete ", message: email);
      await fetchAllUsers();
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {}
  }
}
