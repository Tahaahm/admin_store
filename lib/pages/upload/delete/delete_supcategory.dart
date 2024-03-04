import 'package:admin_store_commerce_shop/common/widgets/shimmer/t_list_shimmer.dart';
import 'package:admin_store_commerce_shop/constant/widgets/app_bar/custom_appbar.dart';
import 'package:admin_store_commerce_shop/pages/upload/controller/upload_category_controller.dart';
import 'package:admin_store_commerce_shop/pages/upload/delete/delete_category.dart';
import 'package:admin_store_commerce_shop/util/constants/colors.dart';
import 'package:admin_store_commerce_shop/util/constants/image_string.dart';
import 'package:admin_store_commerce_shop/util/constants/sizes.dart';
import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class DeleteSupCategoryPage extends StatelessWidget {
  const DeleteSupCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadCategoriesController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Dimentions.height8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TAppBar(
                title: Text("Delete SupCategory"),
                showBackArrow: true,
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return TListShimmer();
                } else {
                  if (controller.supcategories.isEmpty) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(TImage.emptyList, repeat: false),
                          Text("SupCategory list is empty"),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.supcategories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimentions.height10),
                          child: ListTile(
                            onLongPress: () {
                              controller.deleteAccountWarningPopup(
                                  controller.supcategories[index].id);
                            },
                            onTap: () => Get.to(() => DeleteCategoryPage(
                                doc: controller.supcategories[index].id)),
                            leading: Icon(
                              Iconsax.category_25,
                              color: TColors.error,
                              size: TSize.iconLg,
                            ),
                            title: Text(controller.supcategories[index].title),
                            subtitle: Text("Delete SupCategory"),
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
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
