import 'package:admin_store_commerce_shop/common/widgets/shimmer/t_list_shimmer.dart';
import 'package:admin_store_commerce_shop/constant/widgets/app_bar/custom_appbar.dart';
import 'package:admin_store_commerce_shop/pages/upload/brand_upload/controller/brand_controller.dart';
import 'package:admin_store_commerce_shop/pages/upload/delete/delete_brand.dart';
import 'package:admin_store_commerce_shop/util/constants/colors.dart';
import 'package:admin_store_commerce_shop/util/constants/image_string.dart';
import 'package:admin_store_commerce_shop/util/constants/sizes.dart';
import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class DeleteCategoryPage extends StatelessWidget {
  const DeleteCategoryPage({Key? key, required this.doc}) : super(key: key);
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
                title: Text("Delete Category"),
                showBackArrow: true,
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return TListShimmer();
                } else if (controller.categories.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Add the specified content when the list is empty
                        Lottie.asset(TImage.emptyList, repeat: false),
                        Text("Category is empty"),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Dimentions.height10),
                        child: ListTile(
                          onLongPress: () =>
                              controller.deleteAccountWarningPopup(
                                  doc, controller.categories[index].id),
                          onTap: () => Get.to(
                            () => DeleteBrandPage(
                              supCategoryId: doc,
                              categoryId: controller.categories[index].id,
                            ),
                          ),
                          leading: Icon(
                            Iconsax.category,
                            color: TColors.error,
                            size: TSize.iconLg,
                          ),
                          title: Text(controller.categories[index].title),
                          subtitle: Text("upload category to SupCategory"),
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
              }),
            ],
          ),
        ),
      ),
    );
  }
}
