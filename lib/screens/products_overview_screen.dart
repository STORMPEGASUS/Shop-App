import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/widgets/badge.dart';
//import 'package:flutter_complete_guide/providers/product.dart';
//import 'package:flutter_complete_guide/providers/products_provider.dart';
import '../widgets/products_grid.dart';
//import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _OnlyShowFav = false;

  @override
  Widget build(BuildContext context) {
    // final productcontainer = Provider.of<Products>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 255, 213),
        title: const Text(
          'My Shop',
        ),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedvalue) {
              setState(() {
                if (selectedvalue == FilterOptions.Favorites) {
                  //productcontainer.showFavoritesonly();
                  _OnlyShowFav = true;
                } else {
                  //productcontainer.showAll();
                  _OnlyShowFav = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(
                  'Only Favorites',
                ),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text(
                  'Show All',
                ),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, value, ch) => Badge(
              child: ch,
              value: value.itemCount.toString(),
            ),
            child: IconButton(
              onPressed: () {
                
              },
              icon: Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
        ],
      ),
      body: ProductsGrid(_OnlyShowFav),
    );
  }
}
