import 'package:flutter/material.dart';
import 'package:test1/Model/User.dart';
import 'package:test1/Screens/cart_items_page.dart';
import 'package:test1/Screens/home_page.dart';
import 'package:test1/Screens/login_page.dart';
import 'package:test1/Screens/signup_page.dart';
import 'package:test1/Screens/products_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<User> registeredUsers = []; // Shared instance
  final List<Map<String, String>> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => LoginPage(registeredUsers: registeredUsers),
        '/signup': (context) => SignupPage(registeredUsers: registeredUsers),
        '/products': (context) => ProductsPage(cartItems: cartItems),
        '/cart': (context) => CartPage(cartItems: cartItems), // shared list
      },
    );
  }
}
