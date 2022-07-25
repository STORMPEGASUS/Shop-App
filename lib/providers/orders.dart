import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime datetime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.datetime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  final String authtoken;
  Orders(this.authtoken, this._orders);
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        'https://flutter-project-dba11-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json?auth=$authtoken');
    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'datetime': timestamp.toIso8601String(),
        'products': cartProducts
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList(),
      }),
    );

    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        datetime: timestamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }

  Future<void> fetchandsetOrders() async {
    final url = Uri.parse(
        'https://flutter-project-dba11-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json?auth=$authtoken');

    final response = await http.get(url);
    final List<OrderItem> loadeditem = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }

    extractedData.forEach((orderid, orderData) {
      loadeditem.add(
        OrderItem(
          id: orderid,
          amount: orderData['amount'],
          products: (orderData['products'] as List<dynamic>)
              .map(
                (items) => CartItem(
                  id: items['id'],
                  title: items['title'],
                  quantity: items['quantity'],
                  price: items['price'],
                ),
              )
              .toList(),
          datetime: DateTime.parse(
            orderData['datetime'],
          ),
        ),
      );
    });
    _orders = loadeditem.reversed.toList();
    notifyListeners();
  }
}
