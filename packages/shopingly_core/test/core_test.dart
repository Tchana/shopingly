import 'package:flutter_test/flutter_test.dart';
import 'package:shopingly_core/shopingly_core.dart';

void main() {
  group('OrderTotals', () {
    const settings = StoreSettings(taxPercent: 10, shippingFee: 5);

    test('adds shipping and tax to the subtotal', () {
      final t = OrderTotals.compute(subtotal: 100, settings: settings);
      expect(t.shipping, 5);
      expect(t.tax, 10);
      expect(t.total, 115);
    });

    test('taxes only what is paid after the discount', () {
      final t = OrderTotals.compute(subtotal: 100, discount: 20, settings: settings);
      expect(t.discount, 20);
      expect(t.tax, 8);
      expect(t.total, 93);
    });

    test('an empty cart costs nothing', () {
      expect(OrderTotals.compute(subtotal: 0, settings: settings).total, 0);
    });

    test('a discount can never exceed the subtotal', () {
      final t = OrderTotals.compute(subtotal: 10, discount: 50, settings: settings);
      expect(t.discount, 10);
      expect(t.total, 5);
    });

    test('free shipping applies once the threshold is reached', () {
      const free = StoreSettings(taxPercent: 0, shippingFee: 5, freeShippingOver: 50);
      expect(OrderTotals.compute(subtotal: 49.99, settings: free).shipping, 5);
      expect(OrderTotals.compute(subtotal: 50, settings: free).shipping, 0);
    });

    test('rounds to cents', () {
      const odd = StoreSettings(taxPercent: 19.25, shippingFee: 0);
      final t = OrderTotals.compute(subtotal: 9.99, settings: odd);
      expect(t.tax, 1.92);
      expect(t.total, 11.91);
    });
  });

  group('CouponModel', () {
    test('percent coupons take a share of the subtotal', () {
      const c = CouponModel(code: 'TEN', value: 10);
      expect(c.discountFor(200), 20);
    });

    test('fixed coupons never exceed the subtotal', () {
      const c = CouponModel(code: 'BIG', type: CouponType.fixed, value: 50);
      expect(c.discountFor(30), 30);
    });

    test('rejects inactive, expired and under-minimum use', () {
      final now = DateTime(2026, 1, 10);
      expect(const CouponModel(code: 'A', value: 5, isActive: false).validate(100, now: now), isNotNull);
      expect(CouponModel(code: 'B', value: 5, expiresAt: DateTime(2026, 1, 1)).validate(100, now: now), isNotNull);
      expect(const CouponModel(code: 'C', value: 5, minSubtotal: 100).validate(99, now: now), isNotNull);
      expect(const CouponModel(code: 'D', value: 5, minSubtotal: 100).validate(100, now: now), isNull);
    });
  });

  group('ProductModel', () {
    test('sale price only counts when it is below the regular price', () {
      expect(const ProductModel(id: 'a', title: 'A', price: 100, salePrice: 75).effectivePrice, 75);
      expect(const ProductModel(id: 'a', title: 'A', price: 100, salePrice: 75).discountPercent, 25);
      expect(const ProductModel(id: 'a', title: 'A', price: 100, salePrice: 0).effectivePrice, 100);
      expect(const ProductModel(id: 'a', title: 'A', price: 100, salePrice: 120).effectivePrice, 100);
    });

    test('survives a round trip through its map form', () {
      const p = ProductModel(
        id: 'p1',
        title: 'Shoe',
        price: 20.5,
        stock: 3,
        thumbnail: 'assets/a.png',
        images: ['assets/b.png'],
        categoryIds: ['c1', 'c2'],
        attributes: [ProductAttribute(name: 'Size', values: ['S', 'M'])],
      );
      final back = ProductModel.fromMap('p1', p.toJson());
      expect(back.title, 'Shoe');
      expect(back.price, 20.5);
      expect(back.categoryIds, ['c1', 'c2']);
      expect(back.attributes.single.values, ['S', 'M']);
      expect(back.gallery, ['assets/a.png', 'assets/b.png']);
    });

    test('tolerates missing and mistyped fields', () {
      final p = ProductModel.fromMap('x', {'price': '12.5', 'stock': 2.0});
      expect(p.price, 12.5);
      expect(p.stock, 2);
      expect(p.isActive, true);
      expect(p.title, '');
    });
  });

  group('OrderStatus', () {
    test('only allows sensible transitions', () {
      expect(OrderStatus.pending.next, contains(OrderStatus.processing));
      expect(OrderStatus.pending.next, isNot(contains(OrderStatus.delivered)));
      expect(OrderStatus.delivered.next, isEmpty);
      expect(OrderStatus.cancelled.next, isEmpty);
    });

    test('stock is held from processing until the order is cancelled', () {
      expect(OrderStatus.pending.holdsStock, false);
      expect(OrderStatus.processing.holdsStock, true);
      expect(OrderStatus.delivered.holdsStock, true);
      expect(OrderStatus.cancelled.holdsStock, false);
    });
  });

  group('OrderModel', () {
    test('round trips and exposes a short code', () {
      const order = OrderModel(
        id: 'abc123xyz',
        userId: 'u1',
        items: [
          OrderItem(productId: 'p', title: 'T', price: 10, quantity: 2, attributes: {'Size': 'M'}),
        ],
        address: AddressModel(id: '', name: 'N', phone: '1', street: 'S', city: 'C', country: 'K'),
        subtotal: 20,
        total: 20,
      );
      final back = OrderModel.fromMap('abc123xyz', order.toJson());
      expect(back.code, '#ABC123');
      expect(back.itemCount, 2);
      expect(back.items.single.attributesLabel, 'Size: M');
      expect(back.address.formatted, 'S, C, K');
    });
  });

  group('ReviewModel.summarize', () {
    test('averages and buckets ratings', () {
      final reviews = [
        const ReviewModel(id: '1', productId: 'p', userId: '1', userName: 'a', rating: 5),
        const ReviewModel(id: '2', productId: 'p', userId: '2', userName: 'b', rating: 3),
        const ReviewModel(id: '3', productId: 'p', userId: '3', userName: 'c', rating: 4),
      ];
      final s = ReviewModel.summarize(reviews);
      expect(s.count, 3);
      expect(s.average, 4);
      expect(s.perStar, [0, 0, 1, 1, 1]);
    });

    test('no reviews means zero, not NaN', () {
      expect(ReviewModel.summarize(const []).average, 0);
    });
  });
}
