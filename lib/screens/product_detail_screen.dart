import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;

  // ProductDetailScreen(this.title);

  static const routename = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).FindbyId(productId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 255, 213),
        title: Text(loadedProduct.title),
      ),
    );
  }
}
