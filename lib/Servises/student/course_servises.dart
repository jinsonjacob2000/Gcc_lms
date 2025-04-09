// class to aacces the course assigned to a logined Student
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:portfolio_lms/Models/Student_model.dart';
import 'package:portfolio_lms/Utilities/api.dart';

class CourseServises {
  Future<List<Course>> fetchCourses(String token) async {
    final response = await http.get(
      Uri.parse(getcourseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        
      },
    );
    print("---------jjjjjjjjjjj_________");
    print(response.statusCode);
    print(token);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> coursesJson = data['courses'];
      print("----------------ssssssssssssssss-------------");
      print(coursesJson);

      return coursesJson.map((json) => Course.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load courses");
    }
  }
}
