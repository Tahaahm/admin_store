// ignore_for_file: prefer_const_constructors, use_super_parameters

import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:flutter/material.dart';

class TGirdLayout extends StatelessWidget {
  const TGirdLayout({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    required this.mainAxisExtent,
    this.childAspectRatio = 1.0,
  }) : super(key: key);

  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;
  final double childAspectRatio;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: mainAxisExtent,
          mainAxisSpacing: Dimentions.height16,
          crossAxisSpacing: Dimentions.height16,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: itemCount,
        itemBuilder: itemBuilder);
  }
}
