import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Thanh toán")),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: cart.items.entries.map((entry) {
                final product = entry.key;
                final quantity = entry.value;
                return ListTile(
                  title: Text("${product.name} x $quantity"),
                  trailing: Text("${(product.price * quantity).toStringAsFixed(0)} đ"),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text("Tổng cộng: ${cart.totalPrice.toStringAsFixed(0)} đ"),
                SizedBox(height: 10),
                ElevatedButton(
                  child: Text("Xác nhận thanh toán"),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Thanh toán thành công!")),
                    );
                    cart.items.clear();
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
