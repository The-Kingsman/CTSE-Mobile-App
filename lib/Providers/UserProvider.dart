import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:teach_rate/Common/apipath.dart';

class UserProvider with ChangeNotifier {
  addUser(data1) async {
    return await http.post(Uri.parse(APIData.userApi),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer',
          'Connection': 'keep-alive',
        },
        body: jsonEncode(data1));
  }

  getUser(data) async {
    return await http.post(Uri.parse(APIData.usergetApi),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer',
          'Connection': 'keep-alive',
        },
        body: jsonEncode(data));
  }
}