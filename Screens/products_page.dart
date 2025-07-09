import 'package:flutter/material.dart';
import 'package:test1/Screens/cart_items_page.dart';
import 'package:test1/Widgets/products_list_widget.dart';

class ProductsPage extends StatefulWidget {
  final List<Map<String, String>> cartItems;
  const ProductsPage({super.key, required this.cartItems});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final List<Map<String, String>> products = const [
    {'name': 'Apple', 'description': 'Fresh red apples', 'price': '\$2.50'},
    {'name': 'Banana', 'description': 'Organic bananas', 'price': '\$1.20'},
    {
      'name': 'Orange',
      'description': 'Sweet and juicy oranges',
      'price': '\$3.00'
    },
    {
      'name': 'Grapes',
      'description': 'Seedless green grapes',
      'price': '\$2.80'
    },
    {
      'name': 'Strawberry',
      'description': 'Fresh farm strawberries',
      'price': '\$4.00'
    },
    {
      'name': 'Mango',
      'description': 'Tropical ripe mangoes',
      'price': '\$3.50'
    },
    {
      'name': 'Pineapple',
      'description': 'Juicy Hawaiian pineapple',
      'price': '\$2.90'
    },
    {
      'name': 'Blueberry',
      'description': 'Organic blueberries',
      'price': '\$5.20'
    },
    {
      'name': 'Watermelon',
      'description': 'Sweet summer watermelon',
      'price': '\$6.00'
    },
    {'name': 'Kiwi', 'description': 'Tangy and fresh kiwi', 'price': '\$1.80'},
  ];

  final List<Map<String, String>> cartItems = [];

  void _addToCart(Map<String, String> product) {
    setState(() {
      cartItems.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['name']} added to cart'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _goToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(cartItems: cartItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: _goToCart,
            tooltip: 'Go to Cart',
          ),
        ],
      ),
      body: ProductListWidget(
        products: products,
        onAddToCart: _addToCart,
      ),
    );
  }
}
