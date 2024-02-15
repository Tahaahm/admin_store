// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:admin_store_commerce_shop/constant/widgets/app_bar/custom_appbar.dart';
import 'package:admin_store_commerce_shop/pages/upload/controller/upload_sup_category_controller.dart';
import 'package:admin_store_commerce_shop/util/constants/text_strings.dart';
import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:admin_store_commerce_shop/util/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SupCategoryUploadPage extends StatelessWidget {
  const SupCategoryUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadSupCategories());

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TAppBar(
            title: Text("SupCategory"),
            showBackArrow: true,
          ),
          Padding(
            padding: EdgeInsets.all(Dimentions.height15),
            child: Text(
              "Add New SupCategory please",
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
                          TextFormField(
                            controller: controller.titleCategory,
                            validator: (value) => TValidator.validateEmptyText(
                                "SupCategory", value),
                            expands: false,
                            decoration: InputDecoration(
                              label: Text(TText.supCategory),
                              prefixIcon: Icon(Iconsax.category),
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: Dimentions.height32,
                ),
                SizedBox(
                  width: Dimentions.pageView500,
                  child: ElevatedButton(
                      onPressed: () => controller.uploadSupercategory(),
                      child: Text(TText.submit)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
