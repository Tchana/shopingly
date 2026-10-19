import 'package:cloud_firestore/cloud_firestore.dart';
import '../json_utils.dart';

/// Store-wide configuration, edited in the backoffice and read by the mobile app.
class StoreSettings {
  const StoreSettings({
    this.storeName = 'Shopingly',
    this.currencySymbol = r'$',
    this.taxPercent = 10,
    this.shippingFee = 5,
    this.freeShippingOver = 0,
    this.supportEmail = 'support@shopingly.com',
  });

  static const defaults = StoreSettings();

  final String storeName;
  final String currencySymbol;

  /// Percentage, e.g. 19.25 for 19.25%.
  final double taxPercent;
  final double shippingFee;

  /// Orders whose subtotal reaches this amount ship free. 0 disables free shipping.
  final double freeShippingOver;
  final String supportEmail;

  String money(double amount) => '$currencySymbol${amount.toStringAsFixed(2)}';

  Map<String, dynamic> toJson() => {
        'storeName': storeName,
        'currencySymbol': currencySymbol,
        'taxPercent': taxPercent,
        'shippingFee': shippingFee,
        'freeShippingOver': freeShippingOver,
        'supportEmail': supportEmail,
      };

  factory StoreSettings.fromMap(Map<String, dynamic> m) => StoreSettings(
        storeName: readString(m, 'storeName', defaults.storeName),
        currencySymbol: readString(m, 'currencySymbol', defaults.currencySymbol),
        taxPercent: readDouble(m, 'taxPercent', defaults.taxPercent),
        shippingFee: readDouble(m, 'shippingFee', defaults.shippingFee),
        freeShippingOver: readDouble(m, 'freeShippingOver', defaults.freeShippingOver),
        supportEmail: readString(m, 'supportEmail', defaults.supportEmail),
      );

  factory StoreSettings.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> d) =>
      d.exists ? StoreSettings.fromMap(d.data() ?? const {}) : defaults;
}
