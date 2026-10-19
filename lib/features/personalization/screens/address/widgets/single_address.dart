import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';
import 'package:shopingly_core/shopingly_core.dart';

class ShopinglySingleAddress extends StatelessWidget {
  const ShopinglySingleAddress({
    super.key,
    required this.address,
    required this.selectedAddress,
    this.onTap,
    this.onDelete,
  });

  final AddressModel address;
  final bool selectedAddress;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: ShopinglyRoundedContainer(
        padding: EdgeInsets.all(ShopinglySizes.md),
        width: double.infinity,
        showBorder: true,
        backgroundColor: selectedAddress
            ? ShopinglyColors.primaryColor.withValues(alpha: 0.5)
            : Colors.transparent,
        borderColor: selectedAddress
            ? Colors.transparent
            : dark
                ? ShopinglyColors.darkerGrey
                : ShopinglyColors.grey,
        margin: EdgeInsets.only(bottom: ShopinglySizes.spaceBtwItems),
        child: Stack(
          children: [
            Positioned(
              right: 5,
              top: 0,
              child: Row(
                children: [
                  if (selectedAddress)
                    Icon(
                      Iconsax.tick_circle5,
                      color: dark ? ShopinglyColors.light : ShopinglyColors.dark,
                    ),
                  if (onDelete != null)
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: onDelete,
                      icon: const Icon(Iconsax.trash, size: 20),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 72),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(address.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: ShopinglySizes.sm / 2),
                  Text(
                    address.phone,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: ShopinglySizes.sm / 2),
                  Text(
                    address.formatted,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
