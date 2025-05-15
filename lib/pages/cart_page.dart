import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Giỏ hàng")),
      body: ListView(
        children: cart.items.entries.map((entry) {
          final product = entry.key;
          final quantity = entry.value;
          return ListTile(
            leading: Image.network(product.imageUrl),
            title: Text(product.name),
            subtitle: Text("${product.price.toStringAsFixed(0)} đ x $quantity"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.remove), onPressed: () => cart.decreaseQuantity(product)),
                IconButton(icon: Icon(Icons.add), onPressed: () => cart.increaseQuantity(product)),
              ],
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8),
        child: ElevatedButton(
          child: Text("Tiến hành thanh toán - ${cart.totalPrice.toStringAsFixed(0)} đ"),
          onPressed: () => Navigator.pushNamed(context, '/checkout'),
        ),
      ),
    );
  }
}
