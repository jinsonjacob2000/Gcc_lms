import 'package:flutter/material.dart';
import 'package:portfolio_lms/Servises/authentication/auth_servises.dart';

class AuthProvider with ChangeNotifier {
  final AuthServices _authService = AuthServices();
  bool _isLoading = false;
  String? _message;

  bool get isLoading => _isLoading;
  String? get message => _message;

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

  Future<void> loginStudent(String email, String password) async {
    _isLoading = true;
    _message = null;
    notifyListeners();

    final response = await _authService.loginStudent(email, password);

    if (response["success"] == true) {
      _message = "Login successful";
      // Store the token or perform any other actions needed after successful login
      // For example, you can save the token in shared preferences or a secure storage      
      notifyListeners();
    } else {
      _message = response["message"];
      notifyListeners();
    }

    _isLoading = false;
    notifyListeners();
  }
}
