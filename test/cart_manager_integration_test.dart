import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test1/Screens/products_page.dart';

void main() {
  group('Integration Test - Products and Cart', () {
    testWidgets('Add item to cart and remove it', (WidgetTester tester) async {
      final List<Map<String, String>> initialCart = [];

      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => ScaffoldMessenger(child: child!),
          home: ProductsPage(cartItems: initialCart),
        ),
      );

      await tester.pumpAndSettle();

      // 🔍 Check if the ProductListWidget is rendered using its key
      expect(find.byKey(const Key('productList')), findsOneWidget);

      // Tap the "Add to Cart" button
      final Finder addToCartButton = find.byType(ElevatedButton).first;
      await tester.tap(addToCartButton);
      await tester.pump(); // Trigger snackbar
      await tester.pump(const Duration(seconds: 1)); // Wait for snackbar

      // Confirm snackbar appears
      expect(find.text('Apple added to cart'), findsOneWidget);

      // Navigate to Cart
      final Finder cartIcon = find.byIcon(Icons.shopping_cart);
      await tester.tap(cartIcon);
      await tester.pumpAndSettle();

      // Confirm cart has the item and total
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('\$2.50'), findsNWidgets(2)); // price & total
      expect(find.text('Total:'), findsOneWidget);

      // Tap the delete icon
      final Finder deleteButton = find.byIcon(Icons.delete);
      await tester.tap(deleteButton);
      await tester.pump(); // Trigger snackbar
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle(); // Ensure snackbar shows

      // Confirm snackbar and empty cart
      expect(find.text('Item removed from cart'), findsOneWidget);
      expect(find.text('Your cart is empty'), findsOneWidget);
    });
  });

  // Unit test for price calculation
  test('getTotalPrice returns correct sum', () {
    final cartItems = [
      {'name': 'Apple', 'description': 'Fresh red apples', 'price': '\$2.50'},
      {'name': 'Banana', 'description': 'Organic bananas', 'price': '\$1.20'},
    ];

    double getTotalPrice(List<Map<String, String>> items) {
      return items.fold(0.0, (sum, item) {
        final priceString =
            item['price']?.replaceAll(RegExp(r'[^0-9.]'), '') ?? '0';
        return sum + double.tryParse(priceString)!;
      });
    }

    final total = getTotalPrice(cartItems);
    expect(total, 3.7);
  });
}