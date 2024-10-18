import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/utils/constants/sizes.dart';


class ShopinglyRatingAndShare extends StatelessWidget {
  const ShopinglyRatingAndShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Iconsax.star5, color: Colors.amber, size: 24),
            SizedBox(width: ShopinglySizes.spaceBtwItems / 2),
            Text.rich(TextSpan(
                children: [
                  TextSpan(text: '5.0', style: Theme.of(context).textTheme.bodyLarge),
                  TextSpan(text: '(200)')
                ]
            ))
          ],
        ),
        IconButton(onPressed: (){}, icon: Icon(Iconsax.share, size: ShopinglySizes.iconMd,)),
      ],
    );
  }
}