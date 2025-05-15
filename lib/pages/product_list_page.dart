import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductListPage extends StatelessWidget {
  final List<Product> products;

  const ProductListPage({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Danh sách sản phẩm")),
      body: GridView.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (_, index) {
          final product = products[index];
          return Card(
            child: Column(
              children: [
                Image.network(product.imageUrl, height: 100, fit: BoxFit.cover),
                Text(product.name),
                Text("${product.price.toStringAsFixed(0)} đ"),
                ElevatedButton(
                  onPressed: () => cart.addToCart(product),
                  child: Text("Thêm vào giỏ"),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/cart'),
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}