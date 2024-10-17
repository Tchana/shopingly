import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/images/shopingly_circular_image.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/image_strings.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class ShopinglyUserProfileTile extends StatelessWidget {
  const ShopinglyUserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return ListTile(
      leading: ShopinglyCircularImage(
        dark: dark,
        image: ShopinglyImages.user,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text('Tchana Valdo', style: Theme.of(context).textTheme.headlineSmall!.apply(color: ShopinglyColors.white),),
      subtitle: Text('valdotnv@gmail.com', style: Theme.of(context).textTheme.bodyMedium!.apply(color: ShopinglyColors.white),),
      trailing: IconButton(onPressed: (){}, icon: Icon(Iconsax.edit, color: ShopinglyColors.white,)),
    );
  }
}