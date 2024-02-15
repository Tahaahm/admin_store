// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors, unused_local_variable

import 'package:admin_store_commerce_shop/authentication/controller/signup/singup_controller.dart';
import 'package:admin_store_commerce_shop/util/constants/colors.dart';
import 'package:admin_store_commerce_shop/util/constants/text_strings.dart';
import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:admin_store_commerce_shop/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TTermAndCondtionCheckbox extends StatelessWidget {
  const TTermAndCondtionCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SignUpController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Obx(
            () => Checkbox(
              value: controller.privacyPolice.value,
              onChanged: (value) => controller.privacyPolice.value =
                  !controller.privacyPolice.value,
            ),
          ),
        ),
        SizedBox(
          width: Dimentions.width16,
        ),
        Text.rich(TextSpan(children: [
          TextSpan(
            text: "${TText.iAgreeTo} ",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          TextSpan(
            text: "${TText.privacyPolicy} ",
            style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark ? Colors.white : TColors.primaryColor,
                decoration: TextDecoration.underline),
          ),
          TextSpan(
            text: "and ",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          TextSpan(
            text: "${TText.termOfUse}",
            style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark ? Colors.white : TColors.primaryColor,
                decoration: TextDecoration.underline),
          ),
        ]))
      ],
    );
  }
}
