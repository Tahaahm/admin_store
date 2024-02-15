// ignore_for_file: prefer_const_constructors

import 'package:admin_store_commerce_shop/util/constants/colors.dart';
import 'package:admin_store_commerce_shop/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TSectionHeading extends StatelessWidget {
  const TSectionHeading({
    super.key,
    this.onPressed,
    required this.title,
    this.buttonTitle = "View all",
    this.textColor,
    this.showActionButton = false,
  });
  final void Function()? onPressed;
  final String title, buttonTitle;
  final Color? textColor;
  final bool showActionButton;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.apply(
              color: textColor ?? (dark ? TColors.white : TColors.black)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(
              onPressed: onPressed,
              child: Text(
                buttonTitle,
                style: TextStyle(
                  color: dark ? TColors.primaryColor : TColors.primaryColor,
                ),
              )),
        // ignore: sized_box_for_whitespace
      ],
    );
  }
}
