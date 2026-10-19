import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/features/personalization/controllers/address_controller.dart';
import 'package:shopingly/features/personalization/controllers/user_controller.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/validators/validation.dart';
import 'package:shopingly_core/shopingly_core.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _name = TextEditingController(text: UserController.instance.user.value.fullName);
  late final _phone = TextEditingController(text: UserController.instance.user.value.phoneNumber);
  final _street = TextEditingController();
  final _postalCode = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();
  final _country = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    for (final c in [_name, _phone, _street, _postalCode, _city, _state, _country]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving || !_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final saved = await AddressController.instance.add(AddressModel(
      id: '',
      name: _name.text.trim(),
      phone: _phone.text.trim(),
      street: _street.text.trim(),
      postalCode: _postalCode.text.trim(),
      city: _city.text.trim(),
      state: _state.text.trim(),
      country: _country.text.trim(),
    ));
    if (!mounted) return;
    setState(() => _saving = false);
    if (saved) Navigator.of(context).pop();
  }

  String? _required(String label, String? value) => ShopinglyValidator.validateEmptyText(label, value);

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
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _name,
                  validator: (v) => _required('Name', v),
                  decoration: InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: "Name"),
                ),
                SizedBox(height: ShopinglySizes.spaceBtwInputFields,),
                TextFormField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  validator: (v) => _required('Phone number', v),
                  decoration: InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: "Phone Number"),
                ),
                SizedBox(height: ShopinglySizes.spaceBtwInputFields,),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _street,
                        validator: (v) => _required('Street', v),
                        decoration: InputDecoration(prefixIcon: Icon(Iconsax.building_31), labelText: "Street"),
                      ),
                    ),
                    SizedBox(width: ShopinglySizes.spaceBtwInputFields,),
                    Expanded(
                      child: TextFormField(
                        controller: _postalCode,
                        decoration: InputDecoration(prefixIcon: Icon(Iconsax.code), labelText: "Postal code"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ShopinglySizes.spaceBtwInputFields,),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _city,
                        validator: (v) => _required('City', v),
                        decoration: InputDecoration(prefixIcon: Icon(Iconsax.building), labelText: "City"),
                      ),
                    ),
                    SizedBox(width: ShopinglySizes.spaceBtwInputFields,),
                    Expanded(
                      child: TextFormField(
                        controller: _state,
                        decoration: InputDecoration(prefixIcon: Icon(Iconsax.activity), labelText: "State"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ShopinglySizes.spaceBtwInputFields,),
                TextFormField(
                  controller: _country,
                  validator: (v) => _required('Country', v),
                  decoration: InputDecoration(prefixIcon: Icon(Iconsax.global), labelText: "Country"),
                ),
                SizedBox(height: ShopinglySizes.defaultSpace,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saving ? null : _save,
                    child: _saving
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : Text("Save"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
