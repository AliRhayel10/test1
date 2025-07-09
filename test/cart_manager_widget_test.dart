import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test1/Screens/products_page.dart';

void main() {
  testWidgets('ProductsPage displays product and allows adding to cart', (WidgetTester tester) async {
    // Initial empty cart
    final List<Map<String, String>> initialCart = [];

    // Pump the ProductsPage widget
    await tester.pumpWidget(
      MaterialApp(
        home: ProductsPage(cartItems: initialCart),
      ),
    );

    // Check that a product is displayed
    expect(find.text('Apple'), findsOneWidget);
    expect(find.text('Fresh red apples'), findsOneWidget);
    expect(find.text('\$2.50'), findsOneWidget);

    // Find the first AddToCartButton and tap it
    final Finder addToCartButton = find.byType(ElevatedButton).first;
    await tester.tap(addToCartButton);
    await tester.pump(); // Start the snackbar animation

    // Check if snackbar appears
    expect(find.text('Apple added to cart'), findsOneWidget);
  });
}
