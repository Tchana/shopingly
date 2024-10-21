import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class ShopinglySingleAddress extends StatelessWidget {
  const ShopinglySingleAddress({super.key, required this.selectedAddress});

  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return ShopinglyRoundedContainer(
      padding: EdgeInsets.all(ShopinglySizes.md),
      width: double.infinity,
      showBorder: true,
      backgroundColor: selectedAddress
          ? ShopinglyColors.primaryColor.withOpacity(0.5)
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
            child: Icon(
              selectedAddress ? Iconsax.tick_circle5 : null,
              color: selectedAddress
                  ? dark
                      ? ShopinglyColors.light
                      : ShopinglyColors.dark
                  : null,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tchana Valdo",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge
              ),
              SizedBox(height: ShopinglySizes.sm / 2),
              Text(
                  "(+237) 656 388 275",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: ShopinglySizes.sm / 2),
              Text(
                  "Lycée de biyemassi, en face entrée prof, Yaoundé",
                  softWrap: true,

              ),
            ],
          )
        ],
      ),
    );
  }
}
