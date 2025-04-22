// class to aacces the course assigned to a logined Student
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:portfolio_lms/Models/Student_model.dart';
import 'package:portfolio_lms/Models/get_lesson.dart';
import 'package:portfolio_lms/Models/get_module.dart';
import 'package:portfolio_lms/Utilities/api.dart';

class CourseServises {

// Fetch course for the logined student

  Future<List<Course>> fetchCourses(String token) async {
    final response = await http.get(
      Uri.parse(getcourseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    
    if (response.statusCode == 200) {
  final data = jsonDecode(response.body);
  final List<dynamic> coursesJson = data['courses'];

  return coursesJson.map((json) => Course.fromJson(json)).toList();
}
else {
      throw Exception("Failed to load courses");
    }
  }

  // Get modules after tapping on particular course

  Future<List<Module>> getModuleServises(String token, int courseId) async {
    final response = await http.get(
      Uri.parse("$getModuleUrl$courseId"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> modulesJson = data['modules'];
      // print("----------------ssssssssssssssss-------------");
      // print(coursesJson);

      return modulesJson.map((json) => Module.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load courses");
    }
  }

// Get lessons for specific module

  Future<List<Lesson>> getLessonsServises(String token, int courseId,int moduleId) async {
    final response = await http.get(
      Uri.parse("$getLessonUrl$courseId/$moduleId"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    // print("---------jjjjjjjjjjj_________");
    // print(response.statusCode);
    // print(response.body);
    // print(token);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> lessonJson = data['lessons'];
      // print("----------------ssssssssssssssss-------------");
      // print(coursesJson);

      return lessonJson.map((json) => Lesson.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load courses");
    }
  }
}
