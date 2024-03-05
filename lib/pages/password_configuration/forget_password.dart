// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:admin_store_commerce_shop/pages/password_configuration/controller/forget_password_controller.dart';
import 'package:admin_store_commerce_shop/util/constants/text_strings.dart';
import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:admin_store_commerce_shop/util/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FogetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(Dimentions.height12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TText.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: Dimentions.height16,
              ),
              Text(
                TText.forgetPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(height: Dimentions.height60),
              Form(
                key: controller.forgetPasswordFormKey,
                child: TextFormField(
                  controller: controller.email,
                  validator: TValidator.validateEmail,
                  decoration: InputDecoration(
                      labelText: TText.email,
                      prefixIcon: Icon(Iconsax.direct_right)),
                ),
              ),
              SizedBox(
                height: Dimentions.height32,
              ),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                    onPressed: () => controller.sendPasswordResetEmail(),
                    child: Text(TText.submit)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
