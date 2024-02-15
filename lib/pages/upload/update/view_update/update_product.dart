// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print

import 'package:admin_store_commerce_shop/constant/widgets/app_bar/custom_appbar.dart';
import 'package:admin_store_commerce_shop/pages/upload/delete/controller/delete_product.dart';
import 'package:admin_store_commerce_shop/pages/upload/update/controller/update_controller.dart';
import 'package:admin_store_commerce_shop/pages/upload/update/update_product.dart';
import 'package:admin_store_commerce_shop/util/constants/colors.dart';
import 'package:admin_store_commerce_shop/util/constants/sizes.dart';
import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UpdateProductPage extends StatelessWidget {
  const UpdateProductPage(
      {super.key,
      required this.supCategoryId,
      required this.categoryId,
      required this.brandId});
  final String categoryId;
  final String supCategoryId;
  final String brandId;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DeleteController());

    controller.fetchProductsForBrand(supCategoryId, categoryId, brandId);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Dimentions.height8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TAppBar(
                title: Text("Update Product"),
                showBackArrow: true,
              ),
              Obx(
                () => ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: Dimentions.height10),
                      child: ListTile(
                        onTap: () {
                          final updateController = Get.put(UpdateController(
                              product: controller.products[index]));
                          Get.to(() => UpdateProduct(
                                productModel: controller.products[index],
                                supCategoryId: supCategoryId,
                                categoryId: categoryId,
                                brandId: brandId,
                              ));
                        },
                        leading: Icon(
                          Iconsax.shopping_cart,
                          color: TColors.warning,
                          size: TSize.iconLg,
                        ),
                        title: Text(controller.products[index].title),
                        subtitle: Text("Delete Product"),
                        trailing: Icon(
                          Iconsax.arrow_right_41,
                          color: TColors.warning,
                          size: TSize.iconMd,
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
