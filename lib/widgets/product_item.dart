import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:flutter_complete_guide/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  // final String title;
  // final String id;
  // final String imageurl;

  // ProductItem(this.title, this.id, this.imageurl);

  @override
  Widget build(BuildContext context) {
    final providerProduct = Provider.of<Product>(context, listen: false);
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetailScreen.routename,
                  arguments: providerProduct.id);
            },
            child: Image.network(
              providerProduct.imageurl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              builder: (context, value, _) => IconButton(
                color: Color.fromARGB(255, 255, 17, 0),
                icon: Icon(
                  providerProduct.isfavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                onPressed: () {
                  providerProduct.togglestatus();
                },
              ),
            ),
            title: Text(
              providerProduct.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              color: Color.fromARGB(255, 37, 230, 198),
              onPressed: () {},
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ),
      ),
    );
  }
}
