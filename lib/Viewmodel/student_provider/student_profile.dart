import 'package:flutter/material.dart';
import 'package:portfolio_lms/Models/get_profile.dart';
import 'package:portfolio_lms/Servises/student/profile_servises.dart';
import 'package:portfolio_lms/Utilities/tokenManager.dart';

class StudentProfile extends ChangeNotifier {
  final ProfileServises _profileServises = ProfileServises();

  bool _isLoading = false;
  String? _error;

  Profile? _profile;
  Profile? get profile => _profile;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> getProfileProvider(String token, int userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _profile = await _profileServises.fetchProfile(token, userId);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateProfile(String name, String email, String phone) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Call service to update profile
      int? userid = await TokenManager.getUserId();
      String? token = await TokenManager.getToken();
      await _profileServises.updateProfile(name, email, phone, userid!,token!);

      // If update is successful, update the local profile state
      _profile?.name = name;
      _profile?.email = email;
      _profile?.phoneNumber = phone;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
