// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, sized_box_for_whitespace, must_be_immutable, avoid_print, prefer_const_constructors_in_immutables, unrelated_type_equality_checks

import 'package:admin_store_commerce_shop/constant/widgets/app_bar/custom_appbar.dart';
import 'package:admin_store_commerce_shop/pages/upload/upload_product/controller/product_controller.dart';
import 'package:admin_store_commerce_shop/util/constants/colors.dart';
import 'package:admin_store_commerce_shop/util/constants/text_strings.dart';
import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:admin_store_commerce_shop/util/helpers/helper_functions.dart';
import 'package:admin_store_commerce_shop/util/validators/validation.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UploadProduct extends StatelessWidget {
  UploadProduct(
      {super.key,
      required this.categoryId,
      required this.supCategoryId,
      required this.title,
      required this.brandId});
  final String categoryId;
  final String supCategoryId;
  final String brandId;
  final String title;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ProductController());
    controller.brandController.text = title;

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TAppBar(
                title: Text("Product"),
                showBackArrow: true,
              ),
              Padding(
                padding: EdgeInsets.all(Dimentions.height15),
                child: Text(
                  "Add New Product",
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
                    TextFormField(
                      readOnly: true,
                      controller: controller.brandController,
                      expands: false,
                      decoration: InputDecoration(
                        hintText: title,
                        prefixIcon: Icon(Iconsax.language_square),
                      ),
                    ),
                    SizedBox(
                      width: Dimentions.pageView500,
                      child: Form(
                          key: controller.keyForm,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: Dimentions.height45,
                              ),
                              Padding(
                                padding: EdgeInsets.all(Dimentions.height32),
                                child: Obx(() {
                                  return controller.pickedImage.value != null
                                      ? Container(
                                          height: 200,
                                          width: double.infinity,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 0,
                                                  right: 0,
                                                  child: Image.file(
                                                    controller
                                                        .pickedImage.value!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Positioned(
                                                  left: Dimentions.height5,
                                                  top: Dimentions.height10,
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      await controller
                                                          .deletePickedImage();
                                                    },
                                                    child: Container(
                                                      width:
                                                          Dimentions.height30,
                                                      height:
                                                          Dimentions.height30,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimentions
                                                                    .height30),
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
                                            color: dark
                                                ? TColors.white
                                                : TColors.dark,
                                            borderType: BorderType.RRect,
                                            radius: Radius.circular(
                                                Dimentions.height30),
                                            padding: EdgeInsets.all(6),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              child: Container(
                                                height: 200,
                                                width: double.infinity,
                                                child: Icon(
                                                  Iconsax.camera,
                                                  size: 70,
                                                  color: dark
                                                      ? TColors.white
                                                      : TColors.dark,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                }),
                              ),
                              SizedBox(
                                height: Dimentions.height20,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.name,
                                controller: controller.nameProductController,
                                validator: (value) =>
                                    TValidator.validateEmptyText(
                                        TText.nameProduct, value),
                                expands: false,
                                decoration: InputDecoration(
                                  label: Text(TText.nameProduct),
                                  prefixIcon: Icon(Iconsax.emoji_normal),
                                ),
                              ),
                              SizedBox(
                                height: Dimentions.height15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: controller.priceController,
                                      keyboardType: TextInputType.number,
                                      validator: (value) =>
                                          TValidator.validateEmptyText(
                                              TText.priceProduct, value),
                                      expands: false,
                                      decoration: InputDecoration(
                                        label: Text(TText.priceProduct),
                                        prefixIcon:
                                            Icon(Iconsax.money_forbidden),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimentions.height15,
                                  ),
                                  Expanded(
                                    child: DropdownButtonFormField<String>(
                                      value: controller.selectedCurrency.value,
                                      decoration: InputDecoration(
                                        labelText: TText.currencyProduct,
                                        prefixIcon: Icon(Iconsax.chart_square),
                                      ),
                                      items: controller.currencyList
                                          .map((currency) {
                                        return DropdownMenuItem<String>(
                                          value: currency,
                                          child: Text(currency),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.selectedCurrency.value =
                                            value!;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dimentions.height15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: controller.heightController,
                                      keyboardType: TextInputType.number,
                                      validator: (value) =>
                                          TValidator.validateEmptyText(
                                              TText.heightProduct, value),
                                      expands: false,
                                      decoration: InputDecoration(
                                        label: Text(TText.heightProduct),
                                        prefixIcon: Icon(Iconsax.sidebar_top),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimentions.height15,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: controller.widthController,
                                      keyboardType: TextInputType.number,
                                      validator: (value) =>
                                          TValidator.validateEmptyText(
                                              TText.widthProduct, value),
                                      expands: false,
                                      decoration: InputDecoration(
                                        label: Text(TText.widthProduct),
                                        prefixIcon: Icon(Iconsax.weight),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dimentions.height15,
                              ),
                              TextFormField(
                                controller: controller.depthController,
                                keyboardType: TextInputType.number,
                                validator: (value) =>
                                    TValidator.validateEmptyText(
                                        TText.depthProduct, value),
                                expands: false,
                                decoration: InputDecoration(
                                  label: Text(TText.depthProduct),
                                  prefixIcon: Icon(Iconsax.sidebar_bottom),
                                ),
                              ),
                              SizedBox(
                                height: Dimentions.height15,
                              ),
                              SizedBox(
                                height: Dimentions.height15,
                              ),
                              TextFormField(
                                controller: controller.weightController,
                                keyboardType: TextInputType.number,
                                validator: (value) =>
                                    TValidator.validateEmptyText(
                                        TText.kWProduct, value),
                                expands: false,
                                decoration: InputDecoration(
                                  label: Text("Wight"),
                                  prefixIcon: Icon(Iconsax.weight),
                                ),
                              ),
                              SizedBox(
                                height: Dimentions.height15,
                              ),
                              TextFormField(
                                controller: controller.powerController,
                                keyboardType: TextInputType.number,
                                validator: (value) =>
                                    TValidator.validateEmptyText(
                                        TText.kWProduct, value),
                                expands: false,
                                decoration: InputDecoration(
                                  label: Text(TText.kWProduct),
                                  prefixIcon: Icon(Iconsax.electricity),
                                ),
                              ),
                              SizedBox(
                                height: Dimentions.height15,
                              ),
                              TextFormField(
                                controller: controller.stockController,
                                keyboardType: TextInputType.number,
                                validator: (value) =>
                                    TValidator.validateEmptyText(
                                        TText.stockProduct, value),
                                expands: false,
                                decoration: InputDecoration(
                                  label: Text(TText.stockProduct),
                                  prefixIcon: Icon(Iconsax.forward_item),
                                ),
                              ),
                              SizedBox(
                                height: Dimentions.height15,
                              ),
                              TextFormField(
                                controller: controller.materialController,
                                validator: (value) =>
                                    TValidator.validateEmptyText(
                                        TText.materialProduct, value),
                                expands: false,
                                decoration: InputDecoration(
                                  label: Text(TText.materialProduct),
                                  prefixIcon: Icon(Iconsax.forward_item),
                                ),
                              ),
                              SizedBox(
                                height: Dimentions.height15,
                              ),
                              TextFormField(
                                controller: controller.volumeController,
                                keyboardType: TextInputType.number,
                                validator: (value) =>
                                    TValidator.validateEmptyText(
                                        TText.litersProduct, value),
                                expands: false,
                                decoration: InputDecoration(
                                  label: Text(TText.litersProduct),
                                  prefixIcon: Icon(Iconsax.forward_item),
                                ),
                              ),
                              SizedBox(
                                height: Dimentions.height40,
                              ),
                              Obx(() {
                                if (controller.descriptions.isEmpty) {
                                  return Center(
                                    child: Text("Add Description Or Detail"),
                                  );
                                } else {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: controller.descriptions.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: Dimentions.height15),
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: TextEditingController(
                                                text: controller
                                                    .descriptionController.text,
                                              ),
                                              onChanged: (value) {
                                                print(
                                                    'Description value changed: $value');
                                                controller.descriptions[index]
                                                    .value = value;
                                              },
                                              keyboardType: TextInputType.text,
                                              validator: (value) =>
                                                  TValidator.validateEmptyText(
                                                TText.descriptionsProduct,
                                                value,
                                              ),
                                              decoration: InputDecoration(
                                                labelText:
                                                    TText.descriptionsProduct,
                                                prefixIcon:
                                                    Icon(Iconsax.forward_item),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              }),
                              IconButton(
                                  onPressed: () {
                                    controller.addDescription();
                                  },
                                  icon: Icon(Iconsax.add))
                            ],
                          )),
                    ),
                    SizedBox(
                      height: Dimentions.height20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(Dimentions.height15),
          child: SizedBox(
            width: Dimentions.pageView500,
            child: ElevatedButton(
                onPressed: () => controller.uploadProductToBrand(
                    supCategoryId: supCategoryId,
                    categoryId: categoryId,
                    brandId: brandId),
                child: Text(TText.submit)),
          ),
        ));
  }
}
