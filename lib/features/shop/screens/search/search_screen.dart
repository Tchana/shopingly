import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopingly/common/widgets/appbar/appbar.dart';
import 'package:shopingly/common/widgets/layouts/empty_state.dart';
import 'package:shopingly/common/widgets/layouts/grid_layout.dart';
import 'package:shopingly/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shopingly/features/shop/controllers/catalog_controller.dart';
import 'package:shopingly/utils/constants/sizes.dart';

/// Searches product names, brands and SKUs as the customer types.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catalog = CatalogController.instance;
    return Scaffold(
      appBar: ShopinglyAppBar(title: const Text('Search'), showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(ShopinglySizes.defaultSpace),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              autofocus: true,
              textInputAction: TextInputAction.search,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.search_normal),
                hintText: 'Search products, brands...',
                suffixIcon: _controller.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Iconsax.close_circle),
                        onPressed: () => setState(_controller.clear),
                      ),
              ),
            ),
            const SizedBox(height: ShopinglySizes.spaceBtwSections),
            Expanded(
              child: Builder(builder: (_) {
                final query = _controller.text.trim();
                if (query.isEmpty) {
                  return const ShopinglyEmptyState(
                    icon: Iconsax.search_normal,
                    title: 'What are you looking for?',
                    subtitle: 'Type a product name, brand or SKU.',
                  );
                }
                final results = ProductSort.name.apply(catalog.productsFor(query: query));
                if (results.isEmpty) {
                  return ShopinglyEmptyState(
                    icon: Iconsax.search_status,
                    title: 'No results for "$query"',
                    subtitle: 'Try a different word or check the spelling.',
                  );
                }
                return SingleChildScrollView(
                  child: ShopinglyGridLayout(
                    itemCount: results.length,
                    itemBuilder: (_, index) => ShopinglyProductCardVertical(product: results[index]),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
