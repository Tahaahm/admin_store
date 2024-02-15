import 'package:admin_store_commerce_shop/models/user_model.dart';
import 'package:admin_store_commerce_shop/repository/user_repository/user.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;
  final profileLoading = false.obs;
  final hidenPassword = false.obs;
  final imageUplaod = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userReposotory = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecrod();
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
