import 'package:admin_store_commerce_shop/common/widgets/custom_shapes/curve_edge/curved_edge.dart';
import 'package:flutter/material.dart';

class TCurveEdgeWidget extends StatelessWidget {
  const TCurveEdgeWidget({
    super.key,
    this.child,
  });
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TCustomCurvedEdge(),
      child: child,
    );
  }
}
