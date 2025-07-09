import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  final Map<String, String> product;
  final VoidCallback onAdd;

  const AddToCartButton({
    super.key,
    required this.product,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onAdd,
      child: const Text('Add to Cart'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrange[200],
      ),
    );
  }
}
