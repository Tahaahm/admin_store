import 'package:admin_store_commerce_shop/common/widgets/shimmer/t_list_shimmer.dart';
import 'package:admin_store_commerce_shop/constant/widgets/app_bar/custom_appbar.dart';
import 'package:admin_store_commerce_shop/pages/upload/delete/delete_product.dart';
import 'package:admin_store_commerce_shop/pages/upload/upload_product/controller/product_controller.dart';
import 'package:admin_store_commerce_shop/util/constants/colors.dart';
import 'package:admin_store_commerce_shop/util/constants/image_string.dart';
import 'package:admin_store_commerce_shop/util/constants/sizes.dart';
import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class DeleteBrandPage extends StatelessWidget {
  const DeleteBrandPage({
    Key? key,
    required this.supCategoryId,
    required this.categoryId,
  }) : super(key: key);

  final String categoryId;
  final String supCategoryId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Dimentions.height8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TAppBar(
                title: Text("Delete Brand"),
                showBackArrow: true,
              ),
              FutureBuilder<void>(
                future: controller.fetchBrandInCategories(
                    supCategoryId, categoryId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return TListShimmer();
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    if (controller.brands.isEmpty) {
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(TImage.emptyList, repeat: false),
                            Text("Brand list is empty"),
                          ],
                        ),
                      );
                    } else {
                      return Obx(() {
                        if (controller.isLoading.value) {
                          return TListShimmer();
                        } else {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.brands.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Dimentions.height10),
                                child: ListTile(
                                  onLongPress: () =>
                                      controller.deleteAccountWarningPopup(
                                    supCategoryId,
                                    categoryId,
                                    controller.brands[index].id,
                                  ),
                                  onTap: () => Get.to(() => DeleteProductPage(
                                        categoryId: categoryId,
                                        supCategoryId: supCategoryId,
                                        brandId: controller.brands[index].id,
                                      )),
                                  leading: Icon(
                                    Iconsax.language_square,
                                    color: TColors.error,
                                    size: TSize.iconLg,
                                  ),
                                  title: Text(controller.brands[index].title),
                                  subtitle:
                                      Text("upload category to SupCategory"),
                                  trailing: Icon(
                                    Iconsax.arrow_right_41,
                                    color: TColors.error,
                                    size: TSize.iconMd,
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      });
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
