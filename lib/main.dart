import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

import 'models/product.dart';
import 'pages/product_list_page.dart';
import 'pages/cart_page.dart';
import 'pages/checkout_page.dart';
import 'providers/cart_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MaterialApp(
        title: 'Shopping App',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => FutureBuilder<String>(
                future: rootBundle.loadString('assets/products.json'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  } else if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text('Lỗi khi tải dữ liệu: ${snapshot.error}'),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Scaffold(
                      body: Center(
                        child: Text('Không tìm thấy dữ liệu sản phẩm'),
                      ),
                    );
                  } else {
                    final List<dynamic> jsonList = jsonDecode(snapshot.data!);
                    final List<Product> products = jsonList
                        .map((e) => Product.fromJson(e))
                        .toList();

                    return ProductListPage(products: products);
                  }
                },
              ),
          '/cart': (context) => CartPage(),
          '/checkout': (context) => CheckoutPage(),
        },
      ),
    ),
  );
}
