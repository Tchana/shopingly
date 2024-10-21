import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/utils/constants/sizes.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShopinglyAppBar(
        title: Text("Add New Address"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ShopinglySizes.defaultSpace),
          child: Form(
            child: Column(
              children: [
                TextFormField(decoration: InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: "Name"),),
                SizedBox(height: ShopinglySizes.spaceBtwInputFields,),
                TextFormField(decoration: InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: "Phone Number"),),
                SizedBox(height: ShopinglySizes.spaceBtwInputFields,),
                Row(
                  children: [
                    Expanded(child: TextFormField(decoration: InputDecoration(prefixIcon: Icon(Iconsax.building_31), labelText: "Street"),)),
                    SizedBox(width: ShopinglySizes.spaceBtwInputFields,),
                    Expanded(child: TextFormField(decoration: InputDecoration(prefixIcon: Icon(Iconsax.code), labelText: "Postal code"),)),
                  ],
                ),
                SizedBox(height: ShopinglySizes.spaceBtwInputFields,),
                Row(
                  children: [
                    Expanded(child: TextFormField(decoration: InputDecoration(prefixIcon: Icon(Iconsax.building), labelText: "City"),)),
                    SizedBox(width: ShopinglySizes.spaceBtwInputFields,),
                    Expanded(child: TextFormField(decoration: InputDecoration(prefixIcon: Icon(Iconsax.activity), labelText: "State"),)),
                  ],
                ),
                SizedBox(height: ShopinglySizes.spaceBtwInputFields,),
                TextFormField(decoration: InputDecoration(prefixIcon: Icon(Iconsax.global), labelText: "Country"),),
                SizedBox(height: ShopinglySizes.defaultSpace,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: (){}, child: Text("Save")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
