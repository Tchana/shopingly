import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/layouts/empty_state.dart';
import 'package:shopingly/features/personalization/controllers/address_controller.dart';
import 'package:shopingly/features/personalization/screens/address/add_new_address.dart';
import 'package:shopingly/features/personalization/screens/address/widgets/single_address.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly_core/shopingly_core.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        backgroundColor: ShopinglyColors.primaryColor,
        child: Icon(Iconsax.add, color: ShopinglyColors.white),
      ),
      appBar: ShopinglyAppBar(
        showBackArrow: true,
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: controller.fetch,
        child: Obx(() {
          if (controller.isLoading.value && controller.addresses.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.addresses.isEmpty) {
            return ListView(
              children: [
                SizedBox(
                  height: 400,
                  child: ShopinglyEmptyState(
                    icon: Iconsax.location,
                    title: 'No saved addresses',
                    subtitle: 'Add your first shipping address with the + button.',
                  ),
                ),
              ],
            );
          }
          final selectedId = controller.selected?.id;
          return ListView(
            padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
            children: [
              for (final address in controller.addresses)
                ShopinglySingleAddress(
                  address: address,
                  selectedAddress: address.id == selectedId,
                  onTap: () => controller.select(address.id),
                  onDelete: () => _confirmDelete(context, controller, address),
                ),
            ],
          );
        }),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, AddressController controller, AddressModel address) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete this address?'),
        content: Text(address.formatted),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: const Text('Delete')),
        ],
      ),
    );
    if (confirmed == true) await controller.delete(address);
  }
}
