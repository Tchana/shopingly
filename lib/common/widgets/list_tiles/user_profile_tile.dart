import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/images/shopingly_circular_image.dart';
import 'package:shopingly/features/personalization/controllers/user_controller.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/image_strings.dart';

class ShopinglyUserProfileTile extends StatelessWidget {
  const ShopinglyUserProfileTile({
    super.key, this.onPressed,
  });

  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: ShopinglyCircularImage(
        image: ShopinglyImages.user,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Obx(
        () => Text(
          controller.user.value.fullName.isEmpty ? 'Shopingly user' : controller.user.value.fullName,
          style: Theme.of(context).textTheme.headlineSmall!.apply(color: ShopinglyColors.white),
        ),
      ),
      subtitle: Obx(
        () => Text(
          controller.user.value.email,
          style: Theme.of(context).textTheme.bodyMedium!.apply(color: ShopinglyColors.white),
        ),
      ),
      trailing: IconButton(onPressed: onPressed, icon: Icon(Iconsax.edit, color: ShopinglyColors.white,)),
    );
  }
}