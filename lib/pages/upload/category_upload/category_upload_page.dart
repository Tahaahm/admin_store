// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, sized_box_for_whitespace
import 'package:admin_store_commerce_shop/constant/widgets/app_bar/custom_appbar.dart';
import 'package:admin_store_commerce_shop/pages/upload/controller/upload_category_controller.dart';
import 'package:admin_store_commerce_shop/util/constants/colors.dart';
import 'package:admin_store_commerce_shop/util/constants/text_strings.dart';
import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:admin_store_commerce_shop/util/helpers/helper_functions.dart';
import 'package:admin_store_commerce_shop/util/validators/validation.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CategoryUploadPage extends StatelessWidget {
  const CategoryUploadPage({super.key, required this.docs});
  final String docs;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadCategoriesController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TAppBar(
              title: Text("Category"),
              showBackArrow: true,
            ),
            Padding(
              padding: EdgeInsets.all(Dimentions.height15),
              child: Text(
                "Add New Category please",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Dimentions.height32),
              child: Obx(() {
                return controller.pickedImage.value != null
                    ? Container(
                        height: 200,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                right: 0,
                                child: Image.file(
                                  controller.pickedImage.value!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                left: Dimentions.height5,
                                top: Dimentions.height10,
                                child: GestureDetector(
                                  onTap: () async {
                                    await controller.deletePickedImage();
                                  },
                                  child: Container(
                                    width: Dimentions.height30,
                                    height: Dimentions.height30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimentions.height30),
                                      color: TColors.light,
                                    ),
                                    child: Icon(Icons.close),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () => controller.pickImage(),
                        child: DottedBorder(
                          color: dark ? TColors.white : TColors.dark,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(Dimentions.height30),
                          padding: EdgeInsets.all(6),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              child: Icon(
                                Iconsax.camera,
                                size: 70,
                                color: dark ? TColors.white : TColors.dark,
                              ),
                            ),
                          ),
                        ),
                      );
              }),
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
                              controller: controller.categoryName,
                              validator: (value) =>
                                  TValidator.validateEmptyText(
                                      "Category", value),
                              expands: false,
                              decoration: InputDecoration(
                                label: Text(TText.category),
                                prefixIcon: Icon(Iconsax.category),
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
                    height: Dimentions.height32,
                  ),
                  SizedBox(
                    width: Dimentions.pageView500,
                    child: ElevatedButton(
                        onPressed: () => controller.createCategory(docs),
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
