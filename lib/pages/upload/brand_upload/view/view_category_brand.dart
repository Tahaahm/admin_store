import 'package:admin_store_commerce_shop/common/widgets/shimmer/t_list_shimmer.dart';
import 'package:admin_store_commerce_shop/constant/widgets/app_bar/custom_appbar.dart';
import 'package:admin_store_commerce_shop/pages/upload/brand_upload/brand_upload.dart';
import 'package:admin_store_commerce_shop/pages/upload/brand_upload/controller/brand_controller.dart';
import 'package:admin_store_commerce_shop/util/constants/colors.dart';
import 'package:admin_store_commerce_shop/util/constants/image_string.dart';
import 'package:admin_store_commerce_shop/util/constants/sizes.dart';
import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class ViewCategoryBrand extends StatelessWidget {
  const ViewCategoryBrand({
    Key? key,
    required this.doc,
    required this.nameSup,
  }) : super(key: key);

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
                    return TListShimmer();
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return Obx(() {
                      if (controller.isLoading.value) {
                        return TListShimmer();
                      } else if (controller.categories.isEmpty) {
                        return Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(TImage.emptyList, repeat: false),
                              Text("Category is empty"),
                            ],
                          ), // Show message when the list is empty
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
                                onTap: () => Get.to(() => BrandUpload(
                                      categoryId:
                                          controller.categories[index].id,
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
                                subtitle:
                                    Text("upload category to SupCategory"),
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
                    });
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
