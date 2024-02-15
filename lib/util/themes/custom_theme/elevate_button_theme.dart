// ignore_for_file: prefer_const_constructors

import 'package:admin_store_commerce_shop/util/constants/colors.dart';
import 'package:flutter/material.dart';

class TElevatedButtonTheme {
  static ElevatedButtonThemeData lightElevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: TColors.primaryColor,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: BorderSide(
        color: TColors.primaryColor,
      ),
      padding: EdgeInsets.symmetric(vertical: 18),
      textStyle: TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  static ElevatedButtonThemeData darkElevatedButtonTheme =
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
    elevation: 0,
    foregroundColor: Colors.white,
    backgroundColor: TColors.primaryColor,
    disabledForegroundColor: Colors.grey,
    disabledBackgroundColor: Colors.grey,
    side: BorderSide(
      color: TColors.primaryColor,
    ),
    padding: EdgeInsets.symmetric(vertical: 18),
    textStyle: TextStyle(
        fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ));
}
