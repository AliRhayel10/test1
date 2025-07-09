class CartManager {
  final List<Map<String, String>> _cartItems = [];

  List<Map<String, String>> get cartItems => List.unmodifiable(_cartItems);

  void addToCart(Map<String, String> item) {
    _cartItems.add(item);
  }

  void removeFromCartByName(String name) {
    _cartItems.removeWhere((item) => item['name'] == name);
  }

  double getTotalPrice() {
    return _cartItems.fold(0.0, (sum, item) {
      final priceString =
          item['price']?.replaceAll(RegExp(r'[^0-9.]'), '') ?? '0';
      return sum + double.tryParse(priceString)!;
    });
  }

  bool isEmpty() => _cartItems.isEmpty;
}
