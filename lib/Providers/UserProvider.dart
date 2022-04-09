import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:teach_rate/constants.dart';

class UserProvider with ChangeNotifier {
  addUser(data1) async {
    return await http.post(Uri.parse(Constants.userApi),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer',
          'Connection': 'keep-alive',
        },
        body: data1);
  }

  getUser(data) async {
    return await http.post(Uri.parse(Constants.usergetApi),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer',
          'Connection': 'keep-alive',
        },
        body: data);
  }
}
