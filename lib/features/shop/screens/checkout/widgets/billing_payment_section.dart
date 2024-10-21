import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/common/widgets/texts/section_heading.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/image_strings.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        ShopinglySectionHeading(title: "Payment Method", buttonTitle: 'Change', onPressed: (){},),
        SizedBox(height: ShopinglySizes.spaceBtwItems / 2),
        Row(
          children: [
            ShopinglyRoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? ShopinglyColors.light : ShopinglyColors.white,
              padding: EdgeInsets.all(ShopinglySizes.sm),
              child: Image(image: AssetImage(ShopinglyImages.paypal), fit: BoxFit.contain),
            ),
            SizedBox(width: ShopinglySizes.spaceBtwItems / 2),
            Text("Paypal", style: Theme.of(context).textTheme.bodyLarge),
          ],
        )
      ],
    );
  }
}
