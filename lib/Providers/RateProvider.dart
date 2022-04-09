import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:teach_rate/constants.dart';
import 'package:teach_rate/models/AppException.dart';
import 'package:teach_rate/models/Rating.dart';

class RateProvider with ChangeNotifier {
  List<Rating> ratings = [];
  Rating rating = Rating(
    id: '',
    teacherID: '',
    rating: '',
    comment: '',
  );

  Future<void> fetchRatingByTeacher(
    teacherID,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.url}rating/$teacherID'),
      );
      switch (response.statusCode) {
        case 200:
          final extractedCode = json.decode(response.body) as List<dynamic>;
          print(extractedCode);
          final List<Rating> loadedRatings = [];
          extractedCode.forEach(
            (prodData) {
              loadedRatings.add(
                Rating(
                  id: prodData['_id'],
                  teacherID: prodData['teacher_id'],
                  rating: prodData['rating'],
                  comment: prodData['comment'],
                ),
              );
            },
          );
          ratings = loadedRatings;
          notifyListeners();
      }
      notifyListeners();
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<void> fetchRating(id) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.url}rating/$id'),
      );
      switch (response.statusCode) {
        case 200:
          final extractedCode = json.decode(response.body);
          final Rating loadedRating;
          loadedRating = Rating(
            id: extractedCode['_id'],
            teacherID: extractedCode['teacher_id'],
            rating: extractedCode['rating'],
            comment: extractedCode['comment'],
          );
          rating = loadedRating;
          notifyListeners();
      }
      notifyListeners();
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> createRating(
    teacherID,
    rating,
    comment,
  ) async {
    Map<String, dynamic> body = {
      'teacher_id': teacherID,
      'rating': rating,
      'comment': comment,
    };
    try {
      final response = await http.post(
        Uri.parse('${Constants.url}rating/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(body),
      );
      notifyListeners();
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body)['message'].toString();
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> updateRating(
    id,
    teacherID,
    rating,
    comment,
  ) async {
    Map<String, dynamic> body = {
      'teacher_id': teacherID,
      'rating': rating,
      'comment': comment,
    };
    try {
      final response = await http.put(
        Uri.parse('${Constants.url}rating/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(body),
      );
      notifyListeners();
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body)['message'].toString();
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> deleteRating(id) async {
    try {
      final response = await http.delete(
        Uri.parse('${Constants.url}rating/$id'),
      );
      notifyListeners();
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body)['message'].toString();
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }
}
