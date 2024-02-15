// ignore_for_file: prefer_const_constructors, unused_local_variable, file_names

import 'package:admin_store_commerce_shop/pages/onBoarding/controller/onBoarding/controller_onboarding.dart';
import 'package:admin_store_commerce_shop/util/device/device_utilites.dart';
import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:admin_store_commerce_shop/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
      right: Dimentions.height12,
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: dark ? Colors.white : Colors.black,
        ),
        child: Icon(
          Iconsax.arrow_right_3,
          color: dark ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
