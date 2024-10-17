import 'package:flutter/material.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class ShopinglyVerticalImageText extends StatelessWidget {
  const ShopinglyVerticalImageText({
    super.key, required this.image, required this.title, this.textColor = ShopinglyColors.white, this.backgroundColor, this.onTap,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: ShopinglySizes.spaceBtwItems),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              padding: EdgeInsets.all(ShopinglySizes.sm),
              decoration: BoxDecoration(
                color: backgroundColor ?? ( dark ? ShopinglyColors.black : ShopinglyColors.white),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(
                      image),
                  fit: BoxFit.cover,
                  color:dark ? ShopinglyColors.light : ShopinglyColors.dark,
                ),
              ),
            ),
            SizedBox(
                height: ShopinglySizes.spaceBtwItems / 2),
            SizedBox(
                width: 55,
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .apply(
                      color: textColor,),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ))
          ],
        ),
      ),
    );
  }
}