import 'package:admin_store_commerce_shop/constant/widgets/app_bar/custom_appbar.dart';
import 'package:admin_store_commerce_shop/pages/upload/exchange/controller/exchange_controller.dart';
import 'package:admin_store_commerce_shop/util/constants/image_string.dart';
import 'package:admin_store_commerce_shop/util/constants/sizes.dart';
import 'package:admin_store_commerce_shop/util/constants/text_strings.dart';
import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:admin_store_commerce_shop/util/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class ExChangePage extends StatelessWidget {
  const ExChangePage({Key? key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExchangeController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TAppBar(
              title: Text("Exchange"),
              showBackArrow: true,
            ),
            SizedBox(
              height: TSize.spaceBtwSections,
            ),
            Lottie.asset(TImage.exchangeMoney),
            SizedBox(
              height: TSize.spaceBtwInputField,
            ),
            Obx(() {
              if (controller.isFetching.value) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(TImage.processing),
                    Text("Loading The Money")
                  ],
                );
              } else {
                return Container(
                  padding: EdgeInsets.all(12),
                  width: Dimentions.pageView400,
                  child: Form(
                    key: controller.keyForm,
                    child: Column(
                      children: [
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.money),
                            hintText: "\$100",
                          ),
                        ),
                        SizedBox(
                          height: TSize.defaultSpace,
                        ),
                        Center(
                          child: Text(
                            " VS ",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        SizedBox(
                          height: TSize.defaultSpace,
                        ),
                        TextFormField(
                          controller: controller.IQDController,
                          validator: (value) =>
                              TValidator.validateEmptyText("IQD", value),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.money),
                            label: Text("IQD"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            })
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(Dimentions.height15),
        child: SizedBox(
          width: Dimentions.pageView500,
          child: ElevatedButton(
            onPressed: () => controller.uploadExchangeRates(),
            child: Text(TText.update),
          ),
        ),
      ),
    );
  }
}
