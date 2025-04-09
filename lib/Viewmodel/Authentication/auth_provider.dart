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

   if (response["success"] == true) {
    _message = "Login successful";

    print("---------========+++++++++++++========---------");
    print(response["token"]);
    await TokenManager.saveToken(response["token"]);
    _isLoading = false;
    notifyListeners();
    return true; // ✅ Let UI decide what to do next
  } else {
    _message = response["message"];
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
          context, MaterialPageRoute(builder: (context) => Bottomnav()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginStudent()));
    }
    notifyListeners();
  }

   Future<void> studentLogout(BuildContext context) async {
   await TokenManager.clearToken();
    notifyListeners();

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) =>LoginStudent() ));
  }
}
