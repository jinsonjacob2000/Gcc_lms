import 'package:flutter/material.dart';
import 'package:portfolio_lms/Models/coursesModel/Student_model.dart';
import 'package:portfolio_lms/Models/coursesModel/get_lesson.dart';
import 'package:portfolio_lms/Models/coursesModel/get_module.dart';
import 'package:portfolio_lms/Servises/student/course_servises.dart';
import 'package:portfolio_lms/Utilities/tokenManager.dart';

class CourseProvider extends ChangeNotifier {
  // Fetch course for the logined student

  final CourseServises _courseService = CourseServises();
  List<Course> _courses = [];
  List<Module> _modeules = [];
   List<Lesson> _lessons = [];


  bool _isLoading = false;
  String? _error;

  List<Course> get courses => _courses;
  List<Module> get modules => _modeules;
  bool get isLoading => _isLoading;
  String? get error => _error;

// Load user for particular student

  Future<void> loadCourses(String token) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _courses = await _courseService.fetchCourses(token);
     
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Get modules after tapping on particular course

  Future<void> getModules(int courseId) async {
    
    String? token = await TokenManager.getToken();
    if (token == null) {
      print("no token available");
      return;
    }
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _modeules = await _courseService.getModuleServises(token, courseId);
     
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

   Future<void> getLessonProvider(int courseId,int moduleId) async {
    // print("---ccccccccccccccc------");
    // print(courseId);
    String? token = await TokenManager.getToken();
    if (token == null) {
      print("no token available");
      return;
    }
    _isLoading = true;
    _error = null;
    notifyListeners();
    print('-----------------]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]');
    // print(token);
    try {
      _lessons = await _courseService.getLessonsServises(token, courseId,moduleId);
      // print("------------------------pppppppppppppp--------------");
      // print(_courses);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
