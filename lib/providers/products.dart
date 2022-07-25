import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/httpException.dart';
import 'package:http/http.dart' as http;
import './product.dart';
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _items = [];

  final String authToken;
  final String userId;
  Products(this.authToken, this.userId, this._items);

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isfavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  //this function return the future
  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://flutter-project-dba11-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$authToken');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageurl': product.imageurl,
          'price': product.price,
          'userId':userId,
        }),
      );
      final prod = Product(
        id: json.decode(
            response.body)['name'], //giving database id to the product id.
        title: product.title,
        imageurl: product.imageurl,
        description: product.description,
        price: product.price,
      );
      _items.add(prod);
      // _items.add(value);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> UpdateProduct(String id, Product newproduct) async {
    final prodindex = _items.indexWhere((prod) => prod.id == id);
    if (prodindex >= 0) {
      final url = Uri.parse(
          'https://flutter-project-dba11-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$authToken');
      await http.patch(url,
          body: json.encode({
            'title': newproduct.title,
            'price': newproduct.price,
            'description': newproduct.description,
            'imageurl': newproduct.imageurl,
          }));
      _items[prodindex] = newproduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

//whenever we use async we should await for the part which may return value after some time
  Future<void> fetchdataProduct() async {
    var url = Uri.parse(
        'https://flutter-project-dba11-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$authToken');

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProduct = [];
      if (extractedData == null) {
        return;
      }

      url = Uri.parse(
        'https://flutter-project-dba11-default-rtdb.asia-southeast1.firebasedatabase.app/UserFavorites/$userId.json?auth=$authToken',
      );
      final favoriteResponse = await http.get(url);
      final favoritedata = json.decode(favoriteResponse.body);
      extractedData.forEach((prodid, proddata) {
        loadedProduct.add(
          Product(
            id: prodid,
            title: proddata['title'],
            description: proddata['description'],
            price: proddata['price'],
            imageurl: proddata['imageurl'],
            isfavorite:favoritedata==null?false:favoritedata[prodid]??false,
          ),
        );
      });
      _items = loadedProduct;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteproduct(String id) async {
    final url = Uri.parse(
        'https://flutter-project-dba11-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$authToken');
    final existingProductindex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductindex];

    _items.removeAt(existingProductindex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductindex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
