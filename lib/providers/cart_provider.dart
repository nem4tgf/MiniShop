import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final Map<Product, int> _items = {};

  Map<Product, int> get items => _items;

  void addToCart(Product product) {
    if (_items.containsKey(product)) {
      _items[product] = _items[product]! + 1;
    } else {
      _items[product] = 1;
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    if (_items.containsKey(product)) {
      _items.remove(product);
      notifyListeners();
    }
  }

  void increaseQuantity(Product product) {
    _items[product] = _items[product]! + 1;
    notifyListeners();
  }

  void decreaseQuantity(Product product) {
    if (_items[product]! > 1) {
      _items[product] = _items[product]! - 1;
    } else {
      _items.remove(product);
    }
    notifyListeners();
  }

  double get totalPrice => _items.entries
      .map((e) => e.key.price * e.value)
      .fold(0.0, (a, b) => a + b);
}
