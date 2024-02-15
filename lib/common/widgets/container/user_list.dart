// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:admin_store_commerce_shop/common/style/shadow_style.dart';
import 'package:admin_store_commerce_shop/common/widgets/shimmer/t_shimmer_effect.dart';
import 'package:admin_store_commerce_shop/pages/home/controller/home_controller.dart';
import 'package:admin_store_commerce_shop/util/constants/colors.dart';
import 'package:admin_store_commerce_shop/util/constants/image_string.dart';
import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:admin_store_commerce_shop/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key); // Corrected constructor syntax

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final usersController = Get.put(HomeController());
    return Obx(() {
      if (usersController.usersLoading.value) {
        return Padding(
          padding: EdgeInsets.all(Dimentions.height12),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(Dimentions.height12),
                child: TShimmerEffect(
                    width: Dimentions.pageView316,
                    height: Dimentions.height40 * 2),
              );
            },
          ),
        );
      } else if (usersController.userList.isNotEmpty) {
        return RefreshIndicator(
          color: TColors.primaryColor,
          onRefresh: () async {
            usersController.fetchAllUsers();
          },
          child: Padding(
            padding: EdgeInsets.all(Dimentions.height20),
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: usersController.userList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () => usersController.deleteAccountWarningPopup(
                      usersController.userList[index].id,
                      usersController.userList[index].email),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: dark ? TColors.dark : TColors.white,
                        boxShadow: [
                          TShadowStyle.verticalProductShadow,
                          TShadowStyle.verticalProductShadow2,
                        ],
                      ),
                      child: ListTile(
                        trailing: Container(
                          margin: EdgeInsets.only(left: 15),
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: TColors.success.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                        title: Text(usersController.userList[index].firstName),
                        subtitle: Text(usersController.userList[index].email),
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: TColors.darkGrey.withOpacity(0.3),
                          ),
                          child: Lottie.asset(TImage.userProfile,
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      } else {
        if (usersController.userList.isEmpty) {
          return Center(
            child: Column(
              children: [
                Text(
                  "The User is empty",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(height: Dimentions.height30),
                ElevatedButton(
                    onPressed: () {
                      usersController.fetchAllUsers();
                    },
                    child: Text("Load Users", style: TextStyle(fontSize: 8))),
              ],
            ),
          );
        }
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
