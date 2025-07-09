import 'package:flutter/material.dart';
import '/Widgets/add_to_cart_button.dart';

class ProductListWidget extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function(Map<String, String>) onAddToCart;

  const ProductListWidget({
    super.key,
    required this.products,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const Key('productList'), // 👈 Key for the list itself
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          key: Key('productCard_$index'), // 👈 Unique key for each product card
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(product['description']!),
                    ],
                  ),
                ),

                // Price and Add to Cart Button
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      product['price']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AddToCartButton(
                      product: product,
                      onAdd: () => onAddToCart(product),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
