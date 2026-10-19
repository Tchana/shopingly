import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopingly/app.dart';
import 'package:shopingly/data/repositories/authentication/authentication_repository.dart';
import 'package:shopingly/data/repositories/user/user_repository.dart';
import 'package:shopingly/features/personalization/controllers/address_controller.dart';
import 'package:shopingly/features/personalization/controllers/app_settings_controller.dart';
import 'package:shopingly/features/personalization/controllers/user_controller.dart';
import 'package:shopingly/features/shop/controllers/cart_controller.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/features/shop/controllers/order_controller.dart';
import 'package:shopingly/features/shop/controllers/wishlist_controller.dart';
import 'package:shopingly/firebase_options.dart';

/// Run with `--dart-define=USE_FIREBASE_EMULATOR=true` to use the local Firebase Emulator Suite
/// (`firebase emulators:start`) instead of the real project. Ignored in release builds.
const _useEmulator = bool.fromEnvironment('USE_FIREBASE_EMULATOR');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  //Todo: Await native splash

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (_useEmulator && !kReleaseMode) {
    // On Android devices forward the ports first: adb reverse tcp:9099 tcp:9099 && adb reverse tcp:8080 tcp:8080
    await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099, automaticHostMapping: false);
    FirebaseFirestore.instance.useFirestoreEmulator('127.0.0.1', 8080, automaticHostMapping: false);
  }

  Get.put(AppSettingsController(), permanent: true);
  Get.put(UserRepository(), permanent: true);
  Get.put(UserController(), permanent: true);
  Get.put(CatalogController(), permanent: true);
  Get.put(CartController(), permanent: true);
  Get.put(WishlistController(), permanent: true);
  Get.put(AddressController(), permanent: true);
  Get.put(OrderController(), permanent: true);
  // Registered last: once the first frame is up it redirects to the right screen.
  Get.put(AuthenticationRepository(), permanent: true);

  runApp(const App());
}
