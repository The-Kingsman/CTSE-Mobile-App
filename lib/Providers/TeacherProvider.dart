import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:teach_rate/constants.dart';
import 'package:teach_rate/models/AppException.dart';
import 'package:teach_rate/models/Teacher.dart';

class TeacherProvider with ChangeNotifier {
  List<Teacher> teachers = [];
  Teacher teacher = Teacher(
    id: '',
    name: '',
    email: '',
    age: '',
    contact: '',
    experience: '',
    fieldofstudy: '',
    eduQualification: '',
    about: '',
  );

  List<Teacher> getTeachers() {
    return [...teachers];
  }

  Teacher getTeacher() {
    return teacher;
  }

  Future<void> fetchTeachers() async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.url}teacher/'),
      );
      switch (response.statusCode) {
        case 200:
          final extractedCode =
              json.decode(response.body)['results'] as List<dynamic>;
          final List<Teacher> loadedTeachers = [];
          extractedCode.forEach(
            (prodData) {
              loadedTeachers.add(
                Teacher(
                  id: prodData['_id'],
                  name: prodData['name'],
                  email: prodData['email'],
                  age: prodData['age'],
                  contact: prodData['contact'],
                  experience: prodData['experience'],
                  fieldofstudy: prodData['subject'],
                  eduQualification: prodData['qualification'],
                  about: prodData['bio'],
                ),
              );
            },
          );
          teachers = loadedTeachers;
          notifyListeners();
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<void> fetchTeacher(id) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.url}teacher/$id'),
      );
      switch (response.statusCode) {
        case 200:
          final extractedCode = json.decode(response.body);
          final Teacher loadedTeacher;
          loadedTeacher = Teacher(
            id: extractedCode['_id'],
            name: extractedCode['name'],
            email: extractedCode['email'],
            age: extractedCode['age'],
            contact: extractedCode['contact'],
            experience: extractedCode['experience'],
            fieldofstudy: extractedCode['subject'],
            eduQualification: extractedCode['qualification'],
            about: extractedCode['bio'],
          );
          teacher = loadedTeacher;
          notifyListeners();
      }
      notifyListeners();
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> createTeacher(
    name,
    email,
    age,
    contact,
    experience,
    fieldofstudy,
    eduQualification,
    about,
  ) async {
    Map<String, dynamic> body = {
      'name': name,
      'email': email,
      'age': age,
      'contact': contact,
      'experience': experience,
      'subject': fieldofstudy,
      'qualification': eduQualification,
      'bio': about,
    };
    try {
      final response = await http.post(
        Uri.parse('${Constants.url}teacher/'),
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

  Future<dynamic> updateTeacher(
    id,
    name,
    email,
    age,
    contact,
    experience,
    fieldofstudy,
    eduQualification,
    about,
  ) async {
    Map<String, dynamic> body = {
      'name': name,
      'email': email,
      'age': age,
      'contact': contact,
      'experience': experience,
      'subject': fieldofstudy,
      'qualification': eduQualification,
      'bio': about,
    };
    try {
      final response = await http.put(
        Uri.parse('${Constants.url}teacher/$id'),
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

  Future<dynamic> deleteFertilizer(id) async {
    try {
      final response = await http.delete(
        Uri.parse('${Constants.url}teacher/$id'),
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
