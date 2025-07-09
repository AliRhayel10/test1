import 'package:flutter_test/flutter_test.dart';
import 'package:test1/logic/cart_manager.dart';

void main() {
  group('CartManager', () {
    late CartManager cart;

    setUp(() {
      cart = CartManager();
    });

    test('initial cart is empty', () {
      expect(cart.isEmpty(), isTrue);
    });

    test('add item to cart', () {
      cart.addToCart({'name': 'Apple', 'price': '\$2.50'});
      expect(cart.cartItems.length, 1);
      expect(cart.cartItems.first['name'], 'Apple');
    });

    test('remove item from cart by name', () {
      cart.addToCart({'name': 'Apple', 'price': '\$2.50'});
      cart.addToCart({'name': 'Banana', 'price': '\$1.20'});
      cart.removeFromCartByName('Apple');
      expect(cart.cartItems.length, 1);
      expect(cart.cartItems.first['name'], 'Banana');
    });

    test('calculate total price correctly', () {
      cart.addToCart({'name': 'Apple', 'price': '\$2.50'});
      cart.addToCart({'name': 'Banana', 'price': '\$1.20'});
      expect(cart.getTotalPrice(), 3.70);
    });
  });
}