import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/layouts/empty_state.dart';
import 'package:shopingly/common/widgets/layouts/grid_layout.dart';
import 'package:shopingly/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/utils/constants/sizes.dart';
import 'package:shopingly_core/shopingly_core.dart';

/// A grid of products with a sort dropdown.
class ShopinglySortableProducts extends StatefulWidget {
  const ShopinglySortableProducts({
    super.key,
    required this.products,
    this.emptyTitle = 'No products found',
  });

  final List<ProductModel> products;
  final String emptyTitle;

  @override
  State<ShopinglySortableProducts> createState() => _ShopinglySortableProductsState();
}

class _ShopinglySortableProductsState extends State<ShopinglySortableProducts> {
  ProductSort sort = ProductSort.newest;

  @override
  Widget build(BuildContext context) {
    final sorted = sort.apply(widget.products);
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField<ProductSort>(
          initialValue: sort,
          decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          items: ProductSort.values
              .map((option) => DropdownMenuItem(value: option, child: Text(option.label)))
              .toList(),
          onChanged: (value) => setState(() => sort = value ?? sort),
        ),
        SizedBox(height: ShopinglySizes.spaceBtwSections),

        /// -- Products
        if (sorted.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: ShopinglySizes.spaceBtwSections),
            child: ShopinglyEmptyState(title: widget.emptyTitle),
          )
        else
          ShopinglyGridLayout(
            itemCount: sorted.length,
            itemBuilder: (_, index) => ShopinglyProductCardVertical(product: sorted[index]),
          ),
      ],
    );
  }
}
