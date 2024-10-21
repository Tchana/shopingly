import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopingly/features/personalization/screens/address/add_new_address.dart';
import 'package:shopingly/features/personalization/screens/address/widgets/single_address.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddNewAddressScreen()),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
          child: Column(
            children: [
              ShopinglySingleAddress(selectedAddress: true,),
              ShopinglySingleAddress(selectedAddress: false,),
            ],
          ),
        ),
      ),
    );
  }
}
