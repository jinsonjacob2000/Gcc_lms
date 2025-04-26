import 'package:flutter/material.dart';
import 'package:portfolio_lms/Models/coursesModel/Student_model.dart';
import 'package:portfolio_lms/Models/coursesModel/getLive.dart';
import 'package:portfolio_lms/Models/coursesModel/get_assignment.dart';
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
  List<Assignment> _assignment = [];
  List<LiveSession> _livelinks = [];

  bool _isLoading = false;
  String? _error;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<LiveSession> get livelinks => _livelinks;
  List<Assignment> get assignment => _assignment;
  List<Course> get courses => _courses;
  List<Module> get modules => _modeules;
  List<Lesson> get lessons => _lessons;

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

  Future<void> getLessonProvider(int courseId, int moduleId) async {
    String? token = await TokenManager.getToken();
    if (token == null) {
      print("no token available");
      return;
    }
    _isLoading = true;
    _error = null;
    notifyListeners();
    // print(token);
    try {
      _lessons = await _courseService.getLessonsServises(
        token,
        courseId,
        moduleId,
      );
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getLiveProvider(int courseId, int batchid) async {
    String? token = await TokenManager.getToken();
    if (token == null) {
      print("no token available");

      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();
    // print(token);
    try {
      _livelinks = await _courseService.getLiveServices(
        token,
        courseId,
        batchid,
      );

      print("llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll");
      print("@@@@@@@@@@@@@@@@");
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getAssignmentProvider(int courseId, int moduleId) async {
    String? token = await TokenManager.getToken();
    if (token == null) {
      print("no token available");
      return;
    }
    _isLoading = true;
    _error = null;
    notifyListeners();
    // print(token);
    try {
      _assignment = await _courseService.getAssignments(
        token,
        courseId,
        moduleId,
      );
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
