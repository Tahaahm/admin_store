// ignore_for_file: unused_local_variable, avoid_print

import 'package:admin_store_commerce_shop/models/user_model.dart';
import 'package:admin_store_commerce_shop/repository/authentication_repository.dart';
import 'package:admin_store_commerce_shop/util/constants/image_string.dart';
import 'package:admin_store_commerce_shop/util/newtork_manager/network_manager.dart';
import 'package:admin_store_commerce_shop/util/popups/full_screen_loaders.dart';
import 'package:admin_store_commerce_shop/util/popups/loaders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection('Admin').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw TLoaders.errorSnackBar(title: e.toString());
    } on FormatException catch (e) {
      throw TLoaders.errorSnackBar(title: e.toString());
    } on PlatformException catch (e) {
      throw TLoaders.errorSnackBar(title: e.toString());
    } catch (e) {
      throw "Something went wrong.Please try agian";
    }
  }

  //Fetch data
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("Admin")
          .doc(AuthenticationRepository.instance.authUser!.uid)
          .get();

      if (documentSnapshot.exists) {
        return UserModel.fromSnapShot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TLoaders.errorSnackBar(title: e.toString());
    } on FormatException catch (e) {
      throw TLoaders.errorSnackBar(title: e.toString());
    } on PlatformException catch (e) {
      throw TLoaders.errorSnackBar(title: e.toString());
    } catch (e) {
      throw "Something went wrong. Please try again.";
    }
  }

  //update data

  Future<List<UserModel>> fetchAllUsers() async {
    try {
      final querySnapshot = await _db.collection("Users").get();

      List<UserModel> users = [];

      for (var documentSnapshot in querySnapshot.docs) {
        if (documentSnapshot.exists) {
          final userModel = UserModel.fromSnapShot(documentSnapshot);

          // Check if the user's role is "User" before adding to the list
          if (userModel.role == "User") {
            users.add(userModel);
          }
        }
      }

      return users;
    } on FirebaseException catch (e) {
      throw TLoaders.errorSnackBar(title: e.toString());
    } on FormatException catch (e) {
      throw TLoaders.errorSnackBar(title: e.toString());
    } on PlatformException catch (e) {
      throw TLoaders.errorSnackBar(title: e.toString());
    } catch (e) {
      throw "Something went wrong. Please try again.";
    }
  }

  Future<void> removeUserRecord(String userId, String email) async {
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
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw TLoaders.errorSnackBar(title: e.toString());
    } on FormatException catch (e) {
      throw TLoaders.errorSnackBar(title: e.toString());
    } on PlatformException catch (e) {
      throw TLoaders.errorSnackBar(title: e.toString());
    } catch (e) {
      throw "Something went wrong.Please try agian";
    } finally {
      Navigator.of(Get.context!).pop();
      Navigator.of(Get.context!).pop();
    }
  }
}
