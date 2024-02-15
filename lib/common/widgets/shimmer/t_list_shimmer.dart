// ignore_for_file: prefer_const_constructors

import 'package:admin_store_commerce_shop/common/widgets/shimmer/t_shimmer_effect.dart';
import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:flutter/material.dart';

class TListShimmer extends StatelessWidget {
  const TListShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 7,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(Dimentions.height12),
          child: TShimmerEffect(width: double.infinity, height: 60),
        );
      },
    );
  }
}
