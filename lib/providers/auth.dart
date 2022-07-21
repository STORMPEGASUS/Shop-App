import 'package:flutter/widgets.dart';
import 'package:flutter_complete_guide/models/httpException.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signup(String email, String password) async {
    final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDRnPc7e2nP3ayYR3_6e1kAnMK8s3JDzlU',
    );

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            ' returnSecureToken': true,
          },
        ),
      );
    } catch (error) {
      throw error;
    }
  }

  Future<void> signin(String email, String password) async {
    final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDRnPc7e2nP3ayYR3_6e1kAnMK8s3JDzlU',
    );

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );

      final responseData = json.decode(response.body);
      if (responseData != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }
}
