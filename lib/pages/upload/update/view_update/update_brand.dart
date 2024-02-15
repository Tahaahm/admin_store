// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print

import 'package:admin_store_commerce_shop/common/widgets/shimmer/t_list_shimmer.dart';
import 'package:admin_store_commerce_shop/constant/widgets/app_bar/custom_appbar.dart';
import 'package:admin_store_commerce_shop/pages/upload/update/view_update/update_product.dart';
import 'package:admin_store_commerce_shop/pages/upload/upload_product/controller/product_controller.dart';
import 'package:admin_store_commerce_shop/util/constants/colors.dart';
import 'package:admin_store_commerce_shop/util/constants/sizes.dart';
import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UpdateBrandPage extends StatelessWidget {
  const UpdateBrandPage(
      {super.key, required this.supCategoryId, required this.categoryId});
  final String categoryId;
  final String supCategoryId;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    controller.fetchBrandInCategories(supCategoryId, categoryId);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Dimentions.height8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TAppBar(
                title: Text("Update Brand"),
                showBackArrow: true,
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return TListShimmer();
                } else {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.brands.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Dimentions.height10),
                        child: ListTile(
                          onTap: () {
                            print(controller.brands[index].title);
                            Get.to(() => UpdateProductPage(
                                  categoryId: categoryId,
                                  supCategoryId: supCategoryId,
                                  brandId: controller.brands[index].id,
                                ));
                          },
                          leading: Icon(
                            Iconsax.language_square,
                            color: TColors.warning,
                            size: TSize.iconLg,
                          ),
                          title: Text(controller.brands[index].title),
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
              })
            ],
          ),
        ),
      ),
    );
  }
}
