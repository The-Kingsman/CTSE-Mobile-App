import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:teach_rate/constants.dart';
import 'package:teach_rate/models/AppException.dart';
import 'package:teach_rate/models/Class.dart';

class ClassProvider with ChangeNotifier {
  List<Class> classes = [];
  Class tutionClass = Class(
    id: '',
    teacherID: '',
    subject: '',
    grade: '',
    time: '',
    location: '',
    fee: '',
    day: '',
    description: '',
  );

  List<Class> getClasses() {
    return [...classes];
  }

  Class getClass() {
    return tutionClass;
  }

  Future<void> fetchClasses() async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.url}class/'),
      );
      switch (response.statusCode) {
        case 200:
          final extractedCode =
              json.decode(response.body)['results'] as List<dynamic>;
          final List<Class> loadedClasses = [];
          extractedCode.forEach(
            (prodData) {
              loadedClasses.add(
                Class(
                  id: prodData['_id'],
                  teacherID: prodData['teacher_id'],
                  subject: prodData['subject'],
                  grade: prodData['grade'],
                  time: prodData['time'],
                  location: prodData['location'],
                  fee: prodData['fee'],
                  day: prodData['day'],
                  description: prodData['description'],
                ),
              );
            },
          );
          classes = loadedClasses;
          notifyListeners();
      }
      notifyListeners();
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<Class> fetchClass(id) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.url}class/$id'),
      );
      switch (response.statusCode) {
        case 200:
          final extractedCode = json.decode(response.body);
          final Class loadedClass;
          loadedClass = Class(
            id: extractedCode['_id'],
            teacherID: extractedCode['teacher_id'],
            subject: extractedCode['subject'],
            grade: extractedCode['grade'],
            time: extractedCode['time'],
            location: extractedCode['location'],
            fee: extractedCode['fee'],
            day: extractedCode['day'],
            description: extractedCode['description'],
          );
          tutionClass = loadedClass;
          notifyListeners();
      }
      notifyListeners();
      return tutionClass;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> createClass(
    teacherID,
    subject,
    grade,
    time,
    location,
    fee,
    day,
    description,
  ) async {
    Map<String, dynamic> body = {
      'teacher_id': teacherID,
      'subject': subject,
      'grade': grade,
      'time': time,
      'location': location,
      'fee': fee,
      'day': day,
      'description': description,
    };
    try {
      final response = await http.post(
        Uri.parse('${Constants.url}class/'),
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

  Future<dynamic> updateClass(
    id,
    teacherID,
    subject,
    grade,
    time,
    location,
    fee,
    day,
    description,
  ) async {
    Map<String, dynamic> body = {
      'teacher_id': teacherID,
      'subject': subject,
      'grade': grade,
      'time': time,
      'location': location,
      'fee': fee,
      'day': day,
      'description': description,
    };
    try {
      final response = await http.put(
        Uri.parse('${Constants.url}class/$id'),
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

  Future<dynamic> deleteClass(id) async {
    try {
      final response = await http.delete(
        Uri.parse('${Constants.url}class/$id'),
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
