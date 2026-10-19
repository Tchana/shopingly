/// Firestore collection and document names shared by every Shopingly app.
class Col {
  Col._();

  static const users = 'Users';
  static const categories = 'Categories';
  static const brands = 'Brands';
  static const products = 'Products';
  static const banners = 'Banners';
  static const coupons = 'Coupons';
  static const orders = 'Orders';
  static const admins = 'Admins';
  static const settings = 'Settings';

  /// Sub-collections.
  static const addresses = 'Addresses'; // Users/{uid}/Addresses
  static const reviews = 'Reviews'; // Products/{pid}/Reviews

  /// The single document in [settings] that holds the store configuration.
  static const storeSettingsDoc = 'store';
}
