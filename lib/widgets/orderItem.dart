import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/orders.dart';
import 'package:intl/intl.dart';

class Orderitem extends StatefulWidget {
  final OrderItem order;
  Orderitem(this.order);

  @override
  State<Orderitem> createState() => _OrderitemState();
}

class _OrderitemState extends State<Orderitem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded?min(
                  widget.order.products.length * 20.0 + 110,
                  200,
                ):95,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Rs:${widget.order.amount.toStringAsFixed(2)}'),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.datetime),
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                ),
              ),
            ),
            
              AnimatedContainer(
                duration: Duration(milliseconds: 300),

                padding: EdgeInsets.symmetric(vertical: 4,horizontal: 15),
                height: _expanded?min(
                  widget.order.products.length * 20.0 + 10,
                  100,
                ):0,
                child: ListView(
                    children: widget.order.products
                        .map(
                          (prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                prod.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${prod.quantity}x Rs:${prod.price}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList()),
              ),
          ],
        ),
      ),
    );
  }
}
