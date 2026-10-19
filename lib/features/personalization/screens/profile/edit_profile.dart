import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/features/personalization/controllers/user_controller.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly/utils/validators/validation.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _user = UserController.instance.user.value;
  late final _firstName = TextEditingController(text: _user.firstName);
  late final _lastName = TextEditingController(text: _user.lastName);
  late final _username = TextEditingController(text: _user.username);
  late final _phone = TextEditingController(text: _user.phoneNumber);
  bool _saving = false;

  @override
  void dispose() {
    for (final c in [_firstName, _lastName, _username, _phone]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving || !_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final ok = await UserController.instance.updateProfile(
      firstName: _firstName.text,
      lastName: _lastName.text,
      username: _username.text,
      phoneNumber: _phone.text,
    );
    if (!mounted) return;
    setState(() => _saving = false);
    if (ok) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShopinglyAppBar(title: const Text('Edit profile'), showBackArrow: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(ShopinglySizes.defaultSpace),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _firstName,
                      validator: (v) => ShopinglyValidator.validateEmptyText('First name', v),
                      decoration: const InputDecoration(labelText: 'First Name', prefixIcon: Icon(Iconsax.user)),
                    ),
                  ),
                  const SizedBox(width: ShopinglySizes.spaceBtwInputFields),
                  Expanded(
                    child: TextFormField(
                      controller: _lastName,
                      validator: (v) => ShopinglyValidator.validateEmptyText('Last name', v),
                      decoration: const InputDecoration(labelText: 'Last Name', prefixIcon: Icon(Iconsax.user)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ShopinglySizes.spaceBtwInputFields),
              TextFormField(
                controller: _username,
                validator: (v) => ShopinglyValidator.validateEmptyText('Username', v),
                decoration: const InputDecoration(labelText: 'Username', prefixIcon: Icon(Iconsax.user_edit)),
              ),
              const SizedBox(height: ShopinglySizes.spaceBtwInputFields),
              TextFormField(
                controller: _phone,
                keyboardType: TextInputType.phone,
                validator: (v) => ShopinglyValidator.validateEmptyText('Phone number', v),
                decoration: const InputDecoration(labelText: 'Phone Number', prefixIcon: Icon(Iconsax.call)),
              ),
              const SizedBox(height: ShopinglySizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saving ? null : _save,
                  child: _saving
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
