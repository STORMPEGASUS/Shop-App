import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemcount {
    return _items.length;
  }

  void additem(
    String productId,
    double price,
    String title,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingitem) => CartItem(
          id: existingitem.id,
          title: existingitem.title,
          quantity: existingitem.quantity + 1,
          price: existingitem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  double get totalamount {
    var amount = 0.0;
    _items.forEach((key, cartItem) {
      amount += cartItem.price * cartItem.quantity;
    });
    return amount;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCartAfterorder() {
    _items = {};
    notifyListeners();
  }

  void removesingleitem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    if (_items[id].quantity > 1) {
      _items.update(
        id,
        (value) => CartItem(
          id: value.id,
          title: value.title,
          quantity: value.quantity - 1,
          price: value.price,
        ),
      );
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }
}
