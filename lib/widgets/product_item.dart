import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String title;
  final String id;
  final String imageurl;

  ProductItem(this.title, this.id, this.imageurl);

  @override
  Widget build(BuildContext context) {
    return GridTile(child: Image.network(imageurl),);
  }
}
