import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

/// Shows an image that is either bundled with the app (`assets/...`) or hosted online
/// (`https://...`). The back office stores either kind, so every screen goes through here.
class ShopinglyAnyImage extends StatelessWidget {
  const ShopinglyAnyImage({
    super.key,
    required this.path,
    this.fit = BoxFit.contain,
    this.tint,
  });

  final String path;
  final BoxFit? fit;

  /// Only applied to the monochrome category icons under `assets/icons/`.
  final Color? tint;

  static bool isNetwork(String path) => path.startsWith('http://') || path.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty) return _placeholder(context);
    final color = tint != null && path.startsWith('assets/icons/') ? tint : null;
    return Image(
      image: isNetwork(path) ? NetworkImage(path) : AssetImage(path) as ImageProvider,
      fit: fit,
      color: color,
      errorBuilder: (context, _, __) => _placeholder(context),
      loadingBuilder: isNetwork(path)
          ? (context, child, progress) => progress == null
              ? child
              : const Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)))
          : null,
    );
  }

  Widget _placeholder(BuildContext context) => Center(
        child: Icon(Iconsax.image, color: Theme.of(context).disabledColor),
      );
}
