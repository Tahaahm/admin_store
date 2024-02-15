// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:admin_store_commerce_shop/common/widgets/shimmer/t_shimmer_effect.dart';
import 'package:admin_store_commerce_shop/constant/widgets/app_bar/custom_appbar.dart';
import 'package:admin_store_commerce_shop/pages/login/controllers/user_controller.dart';
import 'package:admin_store_commerce_shop/util/constants/text_strings.dart';
import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TText.homeAppBarTitle,
              style: Theme.of(context).textTheme.labelMedium),
          SizedBox(
            height: Dimentions.height5,
          ),
          Obx(() {
            if (controller.profileLoading.value) {
              return TShimmerEffect(
                width: 80,
                height: 15,
              );
            } else {
              return Text(controller.user.value.username,
                  style: Theme.of(context).textTheme.headlineSmall!);
            }
          }),
        ],
      ),
    );
  }
}
