import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:teach_rate/constants.dart';
import 'package:teach_rate/models/AppException.dart';

class UserProvider with ChangeNotifier {
  Future<dynamic> signUp(
    name,
    email,
    age,
    contact,
    password,
    role,
  ) async {
    Map<String, dynamic> body = {
      'name': name,
      'email': email,
      'age': age,
      'contact': contact,
      'password': password,
      'isAdmin': role,
    };
    try {
      final response = await http.post(
        Uri.parse('${Constants.url}user/'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode(body),
      );
      notifyListeners();
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body)['result'];
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> signIn(
    email,
    password,
  ) async {
    Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };
    try {
      final response = await http.post(
        Uri.parse('${Constants.url}user/auth/sign_in'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode(body),
      );
      notifyListeners();
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body)['result'];
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> updateProfile(
    id,
    name,
    email,
    age,
    contact,
    password,
    role,
  ) async {
    Map<String, dynamic> body = {
      'name': name,
      'email': email,
      'age': age,
      'contact': contact,
      'password': password,
      'isAdmin': role,
    };
    try {
      final response = await http.put(
        Uri.parse('${Constants.url}user/$id'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode(body),
      );
      notifyListeners();
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body)['result'];
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }
}
