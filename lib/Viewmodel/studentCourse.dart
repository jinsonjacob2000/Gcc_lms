import 'package:flutter/material.dart';
import 'package:portfolio_lms/Models/Student_model.dart';
import 'package:portfolio_lms/Servises/student/course_servises.dart';
import 'package:portfolio_lms/Utilities/tokenManager.dart';

class CourseProvider extends ChangeNotifier {
  final CourseServises _courseService = CourseServises();
  List<Course> _courses = [];
  bool _isLoading = false;
  String? _error;

  List<Course> get courses => _courses;
  bool get isLoading => _isLoading;
  String? get error => _error;
  final token = TokenManager.getToken();
  Future<void> loadCourses(String token) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    print('-----------------ssssssssssttttttttttt');
    print(token);
    try {
      _courses = await _courseService.fetchCourses(token);
      print("------------------------pppppppppppppp--------------");
      print(_courses);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
