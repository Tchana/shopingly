import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shopingly/data/repositories/review/review_repository.dart';
import 'package:shopingly/features/personalization/controllers/user_controller.dart';
import 'package:shopingly/utils/exceptions/error_messages.dart';
import 'package:shopingly/utils/logging/logger.dart';
import 'package:shopingly/utils/popups/loaders.dart';
import 'package:shopingly_core/shopingly_core.dart';

/// Reviews of a single product. One instance per product, tagged with the product id.
class ReviewController extends GetxController {
  ReviewController(this.productId);

  final String productId;

  static ReviewController of(String productId) => Get.find<ReviewController>(tag: productId);

  final _repository = ReviewRepository();

  final reviews = <ReviewModel>[].obs;
  final isLoading = true.obs;
  final isSaving = false.obs;

  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  ReviewModel? get mine => reviews.firstWhereOrNull((r) => r.userId == _uid);

  ({double average, int count, List<int> perStar}) get summary => ReviewModel.summarize(reviews);

  @override
  void onInit() {
    super.onInit();
    fetch();
  }

  Future<void> fetch() async {
    isLoading.value = true;
    try {
      reviews.assignAll(await _repository.forProduct(productId));
    } catch (e) {
      ShopinglyLoggerHelper.error('Could not load reviews', e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> submit({required double rating, required String comment}) async {
    final uid = _uid;
    if (uid == null || isSaving.value) return false;
    isSaving.value = true;
    try {
      final profile = UserController.instance.user.value;
      await _repository.save(
        productId: productId,
        uid: uid,
        userName: profile.fullName.isEmpty ? 'Customer' : profile.fullName,
        rating: rating,
        comment: comment.trim(),
        exists: mine != null,
      );
      await fetch();
      ShopinglyLoaders.successSnackBar(title: 'Thanks for your review!');
      return true;
    } catch (e) {
      ShopinglyLoggerHelper.error('Could not save the review', e);
      ShopinglyLoaders.errorSnackBar(title: 'Oh Snap!', message: shopinglyErrorMessage(e));
      return false;
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> deleteMine() async {
    final uid = _uid;
    if (uid == null) return;
    try {
      await _repository.delete(productId, uid);
      await fetch();
    } catch (e) {
      ShopinglyLoggerHelper.error('Could not delete the review', e);
      ShopinglyLoaders.errorSnackBar(title: 'Oh Snap!', message: shopinglyErrorMessage(e));
    }
  }
}
