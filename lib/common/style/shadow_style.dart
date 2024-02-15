// ignore_for_file: prefer_const_constructors

import 'package:admin_store_commerce_shop/util/constants/colors.dart';
import 'package:flutter/material.dart';

class TShadowStyle {
  static final verticalProductShadow = BoxShadow(
    color: TColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: Offset(0, 2),
  );
  static final verticalProductShadow2 = BoxShadow(
    color: TColors.grey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: Offset(3, -2),
  );

  static final horizontalProductShadow = BoxShadow(
    color: TColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: Offset(0, 2),
  );
}
