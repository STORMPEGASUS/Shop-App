import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';


class ProductOverviewScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 255, 213),
        title: const Text(
          'My Shop',
        ),
      ),
      body: ProductsGrid(),
    );
  }
}


