import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:teach_rate/constants.dart';
import 'package:teach_rate/models/AppException.dart';
import 'package:teach_rate/models/Rating.dart';

class RateProvider with ChangeNotifier {
  List<Rating> getRatings() {
    return [...ratings];
  }

  Rating getRating() {
    return rating;
  }

  List<Rating> ratings = [];
  Rating rating = Rating(
      id: "",
      user_id: "",
      teacher_id: "",
      username: "",
      rating: "",
      comment: "");

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
          final List<Rating> loadedRatings = [];
          extractedCode.forEach(
            (prodData) {
              loadedRatings.add(
                Rating(
                  id: prodData['_id'],
                  user_id: prodData['user_id'],
                  rating: prodData['rating'],
                  comment: prodData['comment'],
                  teacher_id: prodData['teacher_id'],
                  username: prodData['username'],
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
            user_id: extractedCode['user_id'],
            rating: extractedCode['rating'],
            comment: extractedCode['comment'],
            teacher_id: extractedCode['teacher_id'],
            username: extractedCode['username'],
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
    userID,
    teacherId,
    userName,
    rating,
    comment,
  ) async {
    Map<String, dynamic> body = {
      'user_id': userID,
      'rating': rating,
      'comment': comment,
      'teacher_id': teacherId,
      'username': userName,
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
    userID,
    teacherId,
    userName,
    rating,
    comment,
  ) async {
    Map<String, dynamic> body = {
      'user_id': userID,
      'rating': rating,
      'comment': comment,
      'teacher_id': teacherId,
      'username': userName,
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
