// ignore_for_file: deprecated_member_use
import 'package:flutter_complete_guide/providers/auth.dart';
import 'package:flutter_complete_guide/providers/orders.dart';

import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/screens/auth_screen.dart';

import 'package:flutter_complete_guide/screens/cart_screen.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';
import 'package:flutter_complete_guide/screens/orders_screen.dart';
import 'package:flutter_complete_guide/screens/user_product_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/product_detail_screen.dart';
import 'package:flutter_complete_guide/screens/products_overview_screen.dart';

import 'providers/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (context, auth, previousProduct) => Products(
              auth.token,
              auth.userId,
              previousProduct == null ? [] : previousProduct.items),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (context, auth, previousOrders) => Orders(
              auth.token, previousOrders == null ? [] : previousOrders.orders),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.cyan,
            accentColor: Color.fromARGB(255, 253, 30, 30),
            fontFamily: 'Lato',
          ),
          home: auth.isAuth ? ProductOverviewScreen() : AuthScreen(),
          routes: {
            ProductDetailScreen.routename: (context) => ProductDetailScreen(),
            CartScreen.routename: (context) => CartScreen(),
            OrdersScreen.routename: (ctx) => OrdersScreen(),
            UserProductScreen.routename: (ctx) => UserProductScreen(),
            EditProductScreen.routename: (context) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
