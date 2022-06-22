// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        accentColor: Color.fromARGB(255, 245, 40, 40),
        fontFamily: 'Lato',
      ),
      home: ProductOverviewScreen(),
    );
  }
}


