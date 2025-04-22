import 'package:flutter/material.dart';
import 'package:portfolio_lms/Servises/authentication/auth_servises.dart';
import 'package:portfolio_lms/Utilities/tokenManager.dart';
import 'package:portfolio_lms/View/student/Login_student.dart';
import 'package:portfolio_lms/View/student/bottomNav.dart';

class AuthProvider with ChangeNotifier {
  final AuthServices _authService = AuthServices();
  bool _isLoading = false;
  String? _message;

  bool get isLoading => _isLoading;
  String? get message => _message;

  String? _token;

  // Registration of Student

  Future<void> register(
    String name,
    String email,
    String password,
    String role,
    String phonenumber,
  ) async {
    _isLoading = true;
    _message = null;
    notifyListeners();

    final response = await _authService.registerStudent(
      name,
      email,
      password,
      role,
      phonenumber,
    );

    _message = response["message"];
    print(_message);
    _isLoading = false;
    notifyListeners(); // Update UI
  }

  // Login of Student

  Future<bool> loginStudent(String email, String password) async {
    _isLoading = true;
    _message = null;
    notifyListeners();

    final response = await _authService.loginStudent(email, password);

    print("++++++++++++++++++++++++++++");
    print("Login API response: $response");

    try {
      if (response["token"] != null && response["userData"] != null) {
        _message = "Login successful";

        await TokenManager.saveToken(response["token"]);

        final user = response["userData"];
        final userId = user["userId"];

        if (userId != null) {
          await TokenManager.saveUserId(userId);
        } else {
          print("User ID is null!");
        }

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _message = response["message"] ?? "Login failed";
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _message = "Something went wrong";
      print("Login error: $e");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Autologin of the student

  Future<void> Adminautologin(BuildContext context) async {
    _token = await TokenManager.getToken();
    if (_token != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Bottomnav()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginStudent()),
      );
    }
    notifyListeners();
  }

  Future<void> studentLogout(BuildContext context) async {
    await TokenManager.clearToken();
    notifyListeners();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginStudent()),
    );
  }
}
