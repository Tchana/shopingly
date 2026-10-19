import 'package:get/get.dart';
import 'package:shopingly/features/shop/controllers/cart_controller.dart';
import 'package:shopingly/utils/popups/loaders.dart';
import 'package:shopingly_core/shopingly_core.dart';

/// State of one open product page: the chosen image, options and quantity.
class ProductDetailController extends GetxController {
  ProductDetailController(this.product)
      : selectedImage = (product.gallery.isEmpty ? '' : product.gallery.first).obs,
        selectedAttributes = {
          for (final a in product.attributes)
            if (a.values.isNotEmpty) a.name: a.values.first,
        }.obs;

  final ProductModel product;
  final RxString selectedImage;
  final RxMap<String, String> selectedAttributes;
  final quantity = 1.obs;

  void selectAttribute(String name, String value) => selectedAttributes[name] = value;

  void increment() {
    if (quantity.value >= product.stock) {
      ShopinglyLoaders.warningSnackBar(title: 'Not enough stock', message: 'Only ${product.stock} available.');
      return;
    }
    quantity.value++;
  }

  void decrement() {
    if (quantity.value > 1) quantity.value--;
  }

  /// Returns true if the item was added.
  bool addToCart() {
    final added = CartController.instance.add(
      product,
      quantity: quantity.value,
      attributes: Map<String, String>.from(selectedAttributes),
    );
    if (added) {
      ShopinglyLoaders.successSnackBar(
        title: 'Added to cart',
        message: '${quantity.value} × ${product.title}',
      );
    }
    return added;
  }
}
