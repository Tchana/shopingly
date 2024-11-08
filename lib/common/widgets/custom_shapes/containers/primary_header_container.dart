import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:shopingly/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:shopingly/utils/constants/colors.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    super.key, required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShopinglyCurvedEdgesWidget(
      child: Container(
        color: ShopinglyColors.primaryColor,
        padding: EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: ShopinglyCircularContainer(
                backgroundColor:
                ShopinglyColors.textWhite.withOpacity(0.1),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: ShopinglyCircularContainer(
                backgroundColor:
                ShopinglyColors.textWhite.withOpacity(0.1),
              ),),
            child,
          ],
        ),
      ),
    );
  }
}