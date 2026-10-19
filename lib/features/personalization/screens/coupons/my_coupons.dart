import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/common/widgets/layouts/empty_state.dart';
import 'package:shopingly/data/repositories/coupon/coupon_repository.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/popups/loaders.dart';
import 'package:shopingly_core/shopingly_core.dart';

/// Promo codes the store is currently advertising.
class MyCouponsScreen extends StatefulWidget {
  const MyCouponsScreen({super.key});

  @override
  State<MyCouponsScreen> createState() => _MyCouponsScreenState();
}

class _MyCouponsScreenState extends State<MyCouponsScreen> {
  late Future<List<CouponModel>> _future = CouponRepository().publicCoupons();

  @override
  Widget build(BuildContext context) {
    final money = CatalogController.instance.settings.value.money;
    return Scaffold(
      appBar: ShopinglyAppBar(title: const Text('My Coupons'), showBackArrow: true),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() => _future = CouponRepository().publicCoupons());
          await _future;
        },
        child: FutureBuilder<List<CouponModel>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            final coupons = snapshot.data ?? const [];
            if (snapshot.hasError || coupons.isEmpty) {
              return ListView(children: [
                SizedBox(
                  height: 400,
                  child: ShopinglyEmptyState(
                    icon: Iconsax.discount_shape,
                    title: snapshot.hasError ? "Couldn't load coupons" : 'No coupons right now',
                    subtitle: snapshot.hasError ? 'Pull down to try again.' : 'Check back soon for new offers.',
                  ),
                ),
              ]);
            }
            return ListView.separated(
              padding: const EdgeInsets.all(ShopinglySizes.defaultSpace),
              itemCount: coupons.length,
              separatorBuilder: (_, __) => const SizedBox(height: ShopinglySizes.spaceBtwItems),
              itemBuilder: (_, index) {
                final coupon = coupons[index];
                return ShopinglyRoundedContainer(
                  showBorder: true,
                  padding: const EdgeInsets.all(ShopinglySizes.md),
                  backgroundColor: Colors.transparent,
                  child: Row(
                    children: [
                      const Icon(Iconsax.discount_shape, color: ShopinglyColors.primaryColor, size: 32),
                      const SizedBox(width: ShopinglySizes.spaceBtwItems),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${coupon.code} · ${coupon.label}', style: Theme.of(context).textTheme.titleLarge),
                            if (coupon.description.isNotEmpty)
                              Text(coupon.description, style: Theme.of(context).textTheme.bodyMedium),
                            if (coupon.minSubtotal > 0)
                              Text('Minimum order ${money(coupon.minSubtotal)}',
                                  style: Theme.of(context).textTheme.labelMedium),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Iconsax.copy),
                        onPressed: () async {
                          await Clipboard.setData(ClipboardData(text: coupon.code));
                          ShopinglyLoaders.successSnackBar(title: 'Copied', message: 'Paste ${coupon.code} at checkout.');
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
