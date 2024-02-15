// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:admin_store_commerce_shop/common/widgets/images/t_circular_image.dart';
import 'package:admin_store_commerce_shop/pages/login/controllers/user_controller.dart';
import 'package:admin_store_commerce_shop/util/constants/colors.dart';
import 'package:admin_store_commerce_shop/util/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TUserProfieTitle extends StatelessWidget {
  const TUserProfieTitle({
    super.key,
    this.onPressed,
  });
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final userContoller = UserController.instance;
    return ListTile(
      leading: TCircularImage(
        image: TImage.userProfile,
        height: 50,
        width: 50,
        isNetworkImage: true,
        padding: 0,
        backgroundColor: TColors.white,
        fit: BoxFit.contain,
      ),
      title: Obx(
        () => Text(
          userContoller.user.value.fullName,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: TColors.white),
        ),
      ),
      subtitle: Text(
        userContoller.user.value.email,
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),
      ),
      trailing: IconButton(
        onPressed: onPressed,
        icon: Icon(
          Iconsax.edit,
          color: TColors.white,
        ),
      ),
    );
  }
}
