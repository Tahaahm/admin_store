// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:admin_store_commerce_shop/authentication/controller/signup/verify_email_controller.dart';
import 'package:admin_store_commerce_shop/repository/authentication_repository.dart';
import 'package:admin_store_commerce_shop/util/constants/image_string.dart';
import 'package:admin_store_commerce_shop/util/constants/text_strings.dart';
import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class VerfiyEmailScreen extends StatelessWidget {
  const VerfiyEmailScreen({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => AuthenticationRepository.instance.logout(),
            icon: Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Dimentions.height12),
          child: Column(
            children: [
              Lottie.asset(TImage.verfiy, width: Dimentions.pageView316),
              SizedBox(
                height: Dimentions.height32,
              ),
              Text(
                TText.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Dimentions.height12,
              ),
              Text(
                email,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Dimentions.height16,
              ),
              Text(
                TText.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Dimentions.height32,
              ),
              SizedBox(
                width: Dimentions.pageView316,
                child: ElevatedButton(
                  onPressed: () => controller.checkEmailVerificationStatus(),
                  child: Text(TText.tContinue),
                ),
              ),
              SizedBox(
                height: Dimentions.height32,
              ),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () => controller.sendEmailVerification(),
                      child: Text(TText.resendEmail)))
            ],
          ),
        ),
      ),
    );
  }
}
