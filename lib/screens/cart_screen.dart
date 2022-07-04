// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../providers/cart.dart';
import '../widgets/cartItem.dart' as ci;
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routename ='/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 255, 213),
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            elevation: 10,
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text('Rs:${cart.totalamount}'),
                    backgroundColor: Color.fromARGB(255, 0, 255, 213),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      'ORDER NOW',
                    ),
                    textColor: Color.fromARGB(255, 0, 255, 213),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemcount,
              itemBuilder: (ctx, i) => ci.CartItem(
                  cart.items.values.toList()[i].id,
                  cart.items.keys.toList()[i],
                  cart.items.values.toList()[i].price,
                  cart.items.values.toList()[i].quantity,
                  cart.items.values.toList()[i].title),
            ),
          ),
        ],
      ),
    );
  }
}
