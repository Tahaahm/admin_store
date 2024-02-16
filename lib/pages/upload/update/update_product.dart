// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:admin_store_commerce_shop/constant/widgets/app_bar/custom_appbar.dart';
import 'package:admin_store_commerce_shop/models/products/product_model.dart';
import 'package:admin_store_commerce_shop/pages/upload/update/controller/update_controller.dart';
import 'package:admin_store_commerce_shop/util/constants/colors.dart';
import 'package:admin_store_commerce_shop/util/constants/text_strings.dart';
import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:admin_store_commerce_shop/util/validators/validation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UpdateProduct extends StatelessWidget {
  const UpdateProduct(
      {super.key,
      required this.productModel,
      required this.supCategoryId,
      required this.categoryId,
      required this.brandId});

  final ProductModel productModel;
  final String supCategoryId;
  final String categoryId;
  final String brandId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateController(product: productModel));

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          TAppBar(
            title: Text("Update Product"),
            showBackArrow: true,
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
                            controller: controller.brandController,
                            decoration: InputDecoration(
                              labelText: TText.brand,
                              prefixIcon: Icon(Iconsax.language_square),
                            ),
                          ),
                          SizedBox(
                            height: Dimentions.height45,
                          ),
                          Padding(
                            padding: EdgeInsets.all(Dimentions.height32),
                            child: Container(
                              height: 210,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimentions.height12),
                                border: Border.all(color: TColors.primaryColor),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl: productModel.imageUrl,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                      color: TColors.primaryColor,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Dimentions.height20,
                          ),
                          TextFormField(
                            controller: controller.nameProductController,
                            keyboardType: TextInputType.name,
                            validator: (value) => TValidator.validateEmptyText(
                                TText.nameProduct, value),
                            expands: false,
                            decoration: InputDecoration(
                              label: Text(TText.nameProduct),
                              prefixIcon: Icon(Iconsax.emoji_normal),
                            ),
                            onChanged: (newValue) {
                              controller.updateTextController(
                                  controller.nameProductController, newValue);
                            },
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
                                    prefixIcon: Icon(Iconsax.money_forbidden),
                                  ),
                                  onChanged: (newValue) {
                                    controller.updateTextController(
                                        controller.priceController, newValue);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: Dimentions.height15,
                              ),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: controller.newCurrency,
                                  decoration: InputDecoration(
                                    labelText: TText.currencyProduct,
                                    prefixIcon: Icon(Iconsax.chart_square),
                                  ),
                                  items:
                                      controller.currencyList.map((currency) {
                                    return DropdownMenuItem<String>(
                                      value: currency,
                                      child: Text(currency),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    // Update the text field controller and the currency
                                    controller
                                        .updateTextControllerDropDown(value!);
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
                                  onChanged: (newValue) {
                                    controller.updateTextController(
                                        controller.heightController, newValue);
                                  },
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
                                  onChanged: (newValue) {
                                    controller.updateTextController(
                                        controller.widthController, newValue);
                                  },
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
                            validator: (value) => TValidator.validateEmptyText(
                                TText.depthProduct, value),
                            expands: false,
                            decoration: InputDecoration(
                              label: Text(TText.depthProduct),
                              prefixIcon: Icon(Iconsax.sidebar_bottom),
                            ),
                            onChanged: (newValue) {
                              controller.updateTextController(
                                  controller.depthController, newValue);
                            },
                          ),
                          SizedBox(
                            height: Dimentions.height15,
                          ),
                          TextFormField(
                            controller: controller.weightController,
                            keyboardType: TextInputType.number,
                            validator: (value) => TValidator.validateEmptyText(
                                TText.kWProduct, value),
                            expands: false,
                            decoration: InputDecoration(
                              label: Text("Weight"),
                              prefixIcon: Icon(Iconsax.weight),
                            ),
                            onChanged: (newValue) {
                              controller.updateTextController(
                                  controller.weightController, newValue);
                            },
                          ),
                          SizedBox(
                            height: Dimentions.height15,
                          ),
                          TextFormField(
                            controller: controller.powerController,
                            keyboardType: TextInputType.number,
                            validator: (value) => TValidator.validateEmptyText(
                                TText.kWProduct, value),
                            expands: false,
                            decoration: InputDecoration(
                              label: Text(TText.kWProduct),
                              prefixIcon: Icon(Iconsax.electricity),
                            ),
                            onChanged: (newValue) {
                              controller.updateTextController(
                                  controller.powerController, newValue);
                            },
                          ),
                          SizedBox(
                            height: Dimentions.height15,
                          ),
                          TextFormField(
                            controller: controller.stockController,
                            keyboardType: TextInputType.number,
                            validator: (value) => TValidator.validateEmptyText(
                                TText.stockProduct, value),
                            expands: false,
                            decoration: InputDecoration(
                              label: Text(TText.stockProduct),
                              prefixIcon: Icon(Iconsax.forward_item),
                            ),
                            onChanged: (newValue) {
                              controller.updateTextController(
                                  controller.stockController, newValue);
                            },
                          ),
                          SizedBox(
                            height: Dimentions.height15,
                          ),
                          TextFormField(
                            controller: controller.materialController,
                            validator: (value) => TValidator.validateEmptyText(
                                TText.materialProduct, value),
                            expands: false,
                            decoration: InputDecoration(
                              label: Text(TText.materialProduct),
                              prefixIcon: Icon(Iconsax.forward_item),
                            ),
                            onChanged: (newValue) {
                              controller.updateTextController(
                                  controller.materialController, newValue);
                            },
                          ),
                          SizedBox(
                            height: Dimentions.height15,
                          ),
                          TextFormField(
                            controller: controller.volumeController,
                            keyboardType: TextInputType.number,
                            validator: (value) => TValidator.validateEmptyText(
                                TText.litersProduct, value),
                            expands: false,
                            decoration: InputDecoration(
                              label: Text(TText.litersProduct),
                              prefixIcon: Icon(Iconsax.forward_item),
                            ),
                            onChanged: (newValue) {
                              controller.updateTextController(
                                  controller.volumeController, newValue);
                            },
                          ),
                          SizedBox(
                            height: Dimentions.height40,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.descriptionController.text
                                .split(',')
                                .length,
                            itemBuilder: (context, index) {
                              String item = controller
                                  .descriptionController.text
                                  .split(',')[index]
                                  .trim();
                              return Column(
                                children: [
                                  TextFormField(
                                    initialValue: item,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: 'Description ${index + 1}',
                                      prefixIcon: Icon(Iconsax.forward_item),
                                    ),
                                    onChanged: (value) {
                                      List<String> descriptions = controller
                                          .descriptionController.text
                                          .split(',');
                                      descriptions[index] = value;
                                      // Update the corresponding text controller directly
                                      controller.descriptionController.text =
                                          descriptions.join(',');
                                    },
                                  ),
                                  SizedBox(
                                    height: Dimentions.height20,
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(Dimentions.height15),
        child: SizedBox(
          width: Dimentions.pageView500,
          child: ElevatedButton(
              onPressed: () => controller.updateProduct(
                  supCategoryId, categoryId, brandId, controller.product.id),
              child: Text(TText.update)),
        ),
      ),
    );
  }
}
