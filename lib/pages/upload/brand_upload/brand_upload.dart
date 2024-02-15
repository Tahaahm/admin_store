// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, avoid_print

import 'package:admin_store_commerce_shop/constant/widgets/app_bar/custom_appbar.dart';
import 'package:admin_store_commerce_shop/pages/upload/brand_upload/controller/brand_controller.dart';
import 'package:admin_store_commerce_shop/util/constants/text_strings.dart';
import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:admin_store_commerce_shop/util/helpers/helper_functions.dart';
import 'package:admin_store_commerce_shop/util/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BrandUpload extends StatelessWidget {
  const BrandUpload(
      {super.key,
      required this.categoryId,
      required this.supCategoryId,
      required this.nameCategory});
  final String categoryId;
  final String supCategoryId;
  final String nameCategory;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(BrandController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TAppBar(
              title: Text("Brand $nameCategory"),
              showBackArrow: true,
            ),
            Padding(
              padding: EdgeInsets.all(Dimentions.height15),
              child: Text(
                "Add New Brand please",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            SizedBox(
              height: Dimentions.height32,
            ),
            Padding(
              padding: EdgeInsets.all(Dimentions.height16),
              child: Column(
                children: [
                  SizedBox(
                    width: Dimentions.pageView500,
                    child: Form(
                        key: controller.keyForm,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: Dimentions.height10,
                            ),
                            TextFormField(
                              controller: controller.brandTitle,
                              validator: (value) =>
                                  TValidator.validateEmptyText("Brand", value),
                              expands: false,
                              decoration: InputDecoration(
                                label: Text(TText.brand),
                                prefixIcon: Icon(Iconsax.language_square),
                              ),
                            ),
                            SizedBox(
                              height: Dimentions.height20,
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: Dimentions.height12,
                  ),
                  SizedBox(
                    width: Dimentions.pageView500,
                    child: ElevatedButton(
                        onPressed: () => controller.addBrandToCategory(
                            supCategoryId, categoryId),
                        child: Text(TText.submit)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
