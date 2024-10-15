import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/custom_shapes/curved_edges/curved_edges.dart';

class ShopinglyCurvedEdgesWidget extends StatelessWidget {
  const ShopinglyCurvedEdgesWidget({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ShopinglyCurvedEdges(),
      child: child,
    );
  }
}
