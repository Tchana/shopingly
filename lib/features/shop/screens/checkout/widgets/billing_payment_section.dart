import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/common/widgets/texts/section_heading.dart';
import 'package:shopingly/features/shop/controllers/checkout_controller.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';
import 'package:shopingly_core/shopingly_core.dart';

IconData paymentMethodIcon(PaymentMethod method) => switch (method) {
      PaymentMethod.cashOnDelivery => Iconsax.money,
      PaymentMethod.mobileMoney => Iconsax.mobile,
    };

String paymentMethodHint(PaymentMethod method) => switch (method) {
      PaymentMethod.cashOnDelivery => 'Pay in cash when your order arrives.',
      PaymentMethod.mobileMoney => 'Send the amount by mobile money; the store confirms your payment.',
    };

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key, required this.controller});

  final CheckoutController controller;

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        ShopinglySectionHeading(
          title: "Payment Method",
          buttonTitle: 'Change',
          onPressed: () => _choose(context),
        ),
        SizedBox(height: ShopinglySizes.spaceBtwItems / 2),
        Obx(
          () => Row(
            children: [
              ShopinglyRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark ? ShopinglyColors.light : ShopinglyColors.white,
                padding: EdgeInsets.all(ShopinglySizes.sm),
                child: Icon(paymentMethodIcon(controller.paymentMethod.value), color: ShopinglyColors.primaryColor),
              ),
              SizedBox(width: ShopinglySizes.spaceBtwItems / 2),
              Text(controller.paymentMethod.value.label, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        )
      ],
    );
  }

  void _choose(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(ShopinglySizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select payment method', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: ShopinglySizes.spaceBtwItems),
              for (final method in PaymentMethod.values)
                Obx(
                  () => ListTile(
                    leading: Icon(paymentMethodIcon(method), color: ShopinglyColors.primaryColor),
                    title: Text(method.label),
                    subtitle: Text(paymentMethodHint(method)),
                    trailing: controller.paymentMethod.value == method ? const Icon(Iconsax.tick_circle5) : null,
                    onTap: () {
                      controller.paymentMethod.value = method;
                      Navigator.of(sheetContext).pop();
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
