import 'package:flutter/material.dart';
import 'package:shopingly/common/widgets/texts/section_heading.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';


class BillingAddressSection extends StatelessWidget {
  const BillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShopinglySectionHeading(title: "Shipping Address", buttonTitle: 'Change', onPressed: (){},),
        Text("Tchana Valdo", style: Theme.of(context).textTheme.bodyLarge),
        SizedBox(height: ShopinglySizes.spaceBtwItems / 2),

        Row(
          children: [
            Icon(Icons.phone, color: ShopinglyColors.grey, size: 16),
            SizedBox(width: ShopinglySizes.spaceBtwItems),
            Text('(+237) 656 388 275', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        SizedBox(height: ShopinglySizes.spaceBtwItems / 2),

        Row(
          children: [
            Icon(Icons.location_history, color: ShopinglyColors.grey, size: 16),
            SizedBox(width: ShopinglySizes.spaceBtwItems),
            Text('Lycée de biyemassi, Yaoundé, Cameroun', style: Theme.of(context).textTheme.bodyMedium, softWrap: true,),
          ],
        ),
      ],
    );
  }
}
