import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingly/common/widgets/texts/section_heading.dart';
import 'package:shopingly/features/personalization/controllers/address_controller.dart';
import 'package:shopingly/features/personalization/screens/address/address.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';


class BillingAddressSection extends StatelessWidget {
  const BillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Obx(() {
      final address = controller.selected;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShopinglySectionHeading(
            title: "Shipping Address",
            buttonTitle: address == null ? 'Add' : 'Change',
            onPressed: () => Get.to(() => const UserAddressScreen()),
          ),
          if (address == null)
            Text('No shipping address yet. Add one so we know where to deliver.',
                style: Theme.of(context).textTheme.bodyMedium)
          else ...[
            Text(address.name, style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: ShopinglySizes.spaceBtwItems / 2),

            Row(
              children: [
                Icon(Icons.phone, color: ShopinglyColors.grey, size: 16),
                SizedBox(width: ShopinglySizes.spaceBtwItems),
                Text(address.phone, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            SizedBox(height: ShopinglySizes.spaceBtwItems / 2),

            Row(
              children: [
                Icon(Icons.location_history, color: ShopinglyColors.grey, size: 16),
                SizedBox(width: ShopinglySizes.spaceBtwItems),
                Expanded(
                  child: Text(address.formatted,
                      style: Theme.of(context).textTheme.bodyMedium, softWrap: true),
                ),
              ],
            ),
          ],
        ],
      );
    });
  }
}
