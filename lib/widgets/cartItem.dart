// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
  );
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(
              'Are you sure?',
            ),
            content: Text(
              'Do you want to remove item from the cart?',
            ),
            elevation: 10,
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: Text(
                  'YES',
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: Text(
                  'NO',
                ),
              ),
            ],
          ),
        );
      },
      direction: DismissDirection.endToStart,
      onDismissed: (directions) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        elevation: 10,
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Color.fromARGB(255, 0, 255, 213),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(
                    'Rs:${price}',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: Rs${(price * quantity)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
