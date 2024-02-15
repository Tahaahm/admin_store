// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print

import 'package:admin_store_commerce_shop/common/widgets/shimmer/t_list_shimmer.dart';
import 'package:admin_store_commerce_shop/constant/widgets/app_bar/custom_appbar.dart';
import 'package:admin_store_commerce_shop/pages/upload/brand_upload/controller/brand_controller.dart';
import 'package:admin_store_commerce_shop/pages/upload/update/view_update/update_brand.dart';
import 'package:admin_store_commerce_shop/util/constants/colors.dart';
import 'package:admin_store_commerce_shop/util/constants/sizes.dart';
import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UpdateCategoryPage extends StatelessWidget {
  const UpdateCategoryPage({super.key, required this.doc});
  final String doc;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    controller.fetchCategoriesForSupCategory(doc);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Dimentions.height8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TAppBar(
                title: Text("Update Category"),
                showBackArrow: true,
              ),
              Obx(() {
                if (controller.categories.isNotEmpty) {
                  if (controller.isLoading.value) {
                    return TListShimmer();
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
                            onTap: () => Get.to(
                              () => UpdateBrandPage(
                                supCategoryId: doc,
                                categoryId: controller.categories[index].id,
                              ),
                            ),
                            leading: Icon(
                              Iconsax.category,
                              color: TColors.warning,
                              size: TSize.iconLg,
                            ),
                            title: Text(controller.categories[index].title),
                            subtitle: Text("upload category to SupCategory"),
                            trailing: Icon(
                              Iconsax.arrow_right_41,
                              color: TColors.warning,
                              size: TSize.iconMd,
                            ),
                          ),
                        );
                      },
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
