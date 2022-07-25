import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageurl;
  bool isfavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageurl,
    this.isfavorite = false,
  });

  Future<void> togglestatus(String token, String userId) async {
    final oldstatus = isfavorite;

    isfavorite = !isfavorite;
    notifyListeners();
    final url = Uri.parse(
        'https://flutter-project-dba11-default-rtdb.asia-southeast1.firebasedatabase.app/UserFavorites/$userId/$id.json?auth=$token');
    try {
      final response = await http.put(url,
          body: json.encode(
            isfavorite,
          ));
      if (response.statusCode >= 400) {
        isfavorite = oldstatus;
        notifyListeners();
      }
    } catch (error) {
      isfavorite = oldstatus;

      notifyListeners();
    }
  }
}
