// ignore_for_file: prefer_const_constructors

import 'package:admin_store_commerce_shop/pages/onBoarding/controller/onBoarding/controller_onboarding.dart';
import 'package:flutter/material.dart';

import '../../../../util/constants/sizes.dart';
import '../../../../util/device/device_utilites.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: TSize.defaultSpace,
      child: TextButton(
        onPressed: () => OnBoardingController.instance.skipPage(),
        child: Text("Skip"),
      ),
    );
  }
}
