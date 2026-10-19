import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/features/shop/controllers/cart_controller.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class ShopinglyCouponCode extends StatefulWidget {
  const ShopinglyCouponCode({super.key});

  @override
  State<ShopinglyCouponCode> createState() => _ShopinglyCouponCodeState();
}

class _ShopinglyCouponCodeState extends State<ShopinglyCouponCode> {
  final _code = TextEditingController();

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    final cart = CartController.instance;
    return Obx(() {
      final applied = cart.coupon.value;
      return ShopinglyRoundedContainer(
        showBorder: true,
        backgroundColor: dark ? ShopinglyColors.dark : ShopinglyColors.white,
        padding: EdgeInsets.only(
            top: ShopinglySizes.sm,
            bottom: ShopinglySizes.sm,
            right: ShopinglySizes.sm,
            left: ShopinglySizes.md),
        child: applied != null
            ? Row(
                children: [
                  const Icon(Iconsax.discount_shape, color: ShopinglyColors.primaryColor),
                  const SizedBox(width: ShopinglySizes.spaceBtwItems),
                  Expanded(
                    child: Text('${applied.code} · ${applied.label}',
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  IconButton(onPressed: cart.removeCoupon, icon: const Icon(Iconsax.close_circle)),
                ],
              )
            : Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: _code,
                      textCapitalization: TextCapitalization.characters,
                      onFieldSubmitted: (_) => cart.applyCoupon(_code.text),
                      decoration: InputDecoration(
                        hintText: "Have a promo code? Enter here",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: ElevatedButton(
                      onPressed: cart.isApplyingCoupon.value ? null : () => cart.applyCoupon(_code.text),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: dark
                            ? ShopinglyColors.white.withValues(alpha: 0.5)
                            : ShopinglyColors.dark.withValues(alpha: 0.5),
                        backgroundColor: ShopinglyColors.grey.withValues(alpha: 0.2),
                        side: BorderSide(color: ShopinglyColors.grey.withValues(alpha: 0.1),),
                      ),
                      child: cart.isApplyingCoupon.value
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                          : Text("Apply"),
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
