// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:admin_store_commerce_shop/common/widgets/texts/section_heading.dart';
import 'package:admin_store_commerce_shop/constant/widgets/app_bar/custom_appbar.dart';
import 'package:admin_store_commerce_shop/pages/upload/brand_upload/view/view_sup_category_brand.dart';
import 'package:admin_store_commerce_shop/pages/upload/category_upload/view_category/view_category.dart';
import 'package:admin_store_commerce_shop/pages/upload/delete/delete_supcategory.dart';
import 'package:admin_store_commerce_shop/pages/upload/sup_category_upload/super_category_upload_page.dart';
import 'package:admin_store_commerce_shop/pages/upload/update/view_update/update_supcategory.dart';
import 'package:admin_store_commerce_shop/pages/upload/upload_product/view_product/view_supcategory_product.dart';
import 'package:admin_store_commerce_shop/util/constants/colors.dart';
import 'package:admin_store_commerce_shop/util/constants/sizes.dart';
import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text("Upload Data"),
        showBackArrow: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimentions.height12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TSectionHeading(title: "Main Record"),
            ListTile(
              onTap: () => Get.to(() => SupCategoryUploadPage()),
              leading: Icon(
                Iconsax.category_25,
                color: TColors.primaryColor,
                size: TSize.iconLg,
              ),
              title: Text("Upload SupCategories"),
              trailing: Icon(
                Iconsax.arrow_up_14,
                color: TColors.primaryColor,
                size: TSize.iconMd,
              ),
            ),
            SizedBox(
              height: Dimentions.height16,
            ),
            ListTile(
              onTap: () => Get.to(() => ViewCategory()),
              leading: Icon(
                Iconsax.category,
                color: TColors.primaryColor,
                size: TSize.iconLg,
              ),
              title: Text("Upload Categories"),
              trailing: Icon(
                Iconsax.arrow_up_14,
                color: TColors.primaryColor,
                size: TSize.iconMd,
              ),
            ),
            SizedBox(
              height: Dimentions.height16,
            ),
            ListTile(
              onTap: () => Get.to(() => ViewSupCategoryBrand()),
              leading: Icon(
                Iconsax.language_square,
                color: TColors.primaryColor,
                size: TSize.iconLg,
              ),
              title: Text("Upload Brands"),
              trailing: Icon(
                Iconsax.arrow_up_14,
                color: TColors.primaryColor,
                size: TSize.iconMd,
              ),
            ),
            SizedBox(height: Dimentions.height16),
            ListTile(
              onTap: () => Get.to(() => ViewSupCategoryProduct()),
              leading: Icon(
                Iconsax.shopping_cart,
                color: TColors.primaryColor,
                size: TSize.iconLg,
              ),
              title: Text("Upload Products"),
              trailing: Icon(
                Iconsax.arrow_up_14,
                color: TColors.primaryColor,
                size: TSize.iconMd,
              ),
            ),
            SizedBox(
              height: TSize.spaceBtwItems,
            ),
            SizedBox(
              height: TSize.spaceBtwItems,
            ),
            TSectionHeading(title: "Main Record"),
            Text(
              "Make sure you have alread uploaded all the content above",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: Dimentions.height16),
            ListTile(
              onTap: () => Get.to(() => DeleteSupCategoryPage()),
              leading: Icon(
                Iconsax.cloud_remove,
                color: TColors.error,
                size: TSize.iconLg,
              ),
              title: Text(
                "Delete SupCategor & Category & Brands & Products",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: Icon(
                Iconsax.arrow_down_2,
                color: TColors.error,
                size: TSize.iconMd,
              ),
            ),
            SizedBox(
              height: TSize.spaceBtwItems,
            ),
            ListTile(
              onTap: () => Get.to(() => UpdateSupCategory()),
              leading: Icon(
                Iconsax.cloud_change,
                color: TColors.warning,
                size: TSize.iconLg,
              ),
              title: Text(
                "Update Products",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: Icon(
                Iconsax.document_upload,
                color: TColors.warning,
                size: TSize.iconMd,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
