import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shopingly/features/authentication/screens/login/login.dart';
import 'package:shopingly/features/authentication/screens/onboarding/onboarding.dart';
import 'package:shopingly/features/authentication/screens/signup/verify_email.dart';
import 'package:shopingly/navigation_menu.dart';
import 'package:shopingly/utils/exceptions/error_messages.dart';
import 'package:shopingly/utils/local_storage/storage_utility.dart';
import 'package:shopingly/utils/logging/logger.dart';
import 'package:shopingly/utils/popups/loaders.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  static const isFirstTimeKey = 'IsFirstTime';

  final _auth = FirebaseAuth.instance;
  final _storage = ShopinglyLocalStorage();

  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    super.onReady();
    screenRedirect();
  }

  /// Sends the user to the screen that matches their current auth state.
  void screenRedirect() {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: user.email));
      }
    } else {
      final isFirstTime = _storage.readData<bool>(isFirstTimeKey) ?? true;
      Get.offAll(() => isFirstTime ? const OnBoardingScreen() : const LoginScreen());
    }
  }

  Future<UserCredential> loginWithEmailAndPassword(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> registerWithEmailAndPassword(String email, String password) {
    return _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> sendEmailVerification() async {
    await _auth.currentUser?.sendEmailVerification();
  }

  Future<void> sendPasswordResetEmail(String email) {
    return _auth.sendPasswordResetEmail(email: email);
  }

  /// Refreshes the signed-in user from Firebase and reports whether their email is verified.
  Future<bool> reloadAndCheckEmailVerified() async {
    await _auth.currentUser?.reload();
    return _auth.currentUser?.emailVerified ?? false;
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      ShopinglyLoggerHelper.error('Logout failed', e);
      ShopinglyLoaders.errorSnackBar(
          title: 'Oh Snap!', message: shopinglyErrorMessage(e));
    }
  }
}
