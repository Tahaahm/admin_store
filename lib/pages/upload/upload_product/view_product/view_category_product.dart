// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print

import 'package:admin_store_commerce_shop/common/widgets/shimmer/t_list_shimmer.dart';
import 'package:admin_store_commerce_shop/constant/widgets/app_bar/custom_appbar.dart';
import 'package:admin_store_commerce_shop/pages/upload/brand_upload/controller/brand_controller.dart';
import 'package:admin_store_commerce_shop/pages/upload/upload_product/view_product/view_brand_product.dart';
import 'package:admin_store_commerce_shop/util/constants/colors.dart';
import 'package:admin_store_commerce_shop/util/constants/sizes.dart';
import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ViewCategoryProduct extends StatelessWidget {
  const ViewCategoryProduct(
      {super.key, required this.doc, required this.nameSup});
  final String doc;
  final String nameSup;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Dimentions.height8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TAppBar(
                title: Text("View Category $nameSup"),
                showBackArrow: true,
              ),
              FutureBuilder<void>(
                future: controller.fetchCategoriesForSupCategory(doc),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return TListShimmer(); // Show shimmer while loading
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(
                            color: Colors.red), // Style the error message
                      ), // Show error message if error occurs
                    );
                  } else {
                    // Check if categories list is empty
                    if (controller.categories.isEmpty) {
                      return Center(
                        child:
                            CircularProgressIndicator(), // Show loading indicator if categories are empty
                      );
                    } else {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.categories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimentions.height10),
                            child: ListTile(
                              onTap: () => Get.to(() => ViewBrandProduct(
                                    categoryId: controller.categories[index].id,
                                    supCategoryId: doc,
                                    nameCategory:
                                        controller.categories[index].title,
                                  )),
                              leading: Icon(
                                Iconsax.category,
                                color: TColors.primaryColor,
                                size: TSize.iconLg,
                              ),
                              title: Text(controller.categories[index].title),
                              subtitle: Text("upload category to SupCategory"),
                              trailing: Icon(
                                Iconsax.arrow_right_41,
                                color: TColors.primaryColor,
                                size: TSize.iconMd,
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
