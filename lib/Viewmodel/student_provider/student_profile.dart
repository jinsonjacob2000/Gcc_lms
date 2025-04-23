import 'package:flutter/material.dart';
import 'package:portfolio_lms/Models/profileModel/get_attendance.dart';
import 'package:portfolio_lms/Models/profileModel/get_profile.dart';
import 'package:portfolio_lms/Servises/student/profile_servises.dart';
import 'package:portfolio_lms/Utilities/tokenManager.dart';

class StudentProfile extends ChangeNotifier {
  final ProfileServises _profileServises = ProfileServises();

  bool _isLoading = false;
  String? _error;

  List<LeaveRequest> _leaveHistory = [];
  List<LeaveRequest> get leaveHistory => _leaveHistory;

  Profile? _profile;
  Profile? get profile => _profile;

  bool get isLoading => _isLoading;
  String? get error => _error;

  List<Attendance> _records = [];

  List<Attendance> get records => _records;

  List<Attendance> _attendanceList = [];
  int _totalAttendance = 0;

  List<Attendance> get attendanceList => _attendanceList;
  int get totalAttendance => _totalAttendance;

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
      await _profileServises.updateProfile(name, email, phone, userid!, token!);

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

  Future<void> sendLeaveREquestprovider(DateTime date, String reason) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Call service to update profile
      String? token = await TokenManager.getToken();

      await _profileServises.sendMedicalleave(date, reason, token!);

      // If update is successful, update the local profile state
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchLeaveHistory() async {
    print("test22222222");
    try {
      _isLoading = true;
      notifyListeners();

      String? token = await TokenManager.getToken();
      _leaveHistory = await _profileServises.getLeaveHistory(token!);
      print(_leaveHistory);
    } catch (e) {
      _error = e.toString();
      print("#####################");
      print(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadAttendance() async {
    _isLoading = true;
    notifyListeners();

    try {
      final token = await TokenManager.getToken();
      final studentId = await TokenManager.getUserId();

      final result = await _profileServises.fetchAttendance(token!, studentId!);
      _attendanceList = result['attendanceList'];
      _totalAttendance = result['totalCount'];
      print("in provider ");
      print(result);
    } catch (e) {
      _error = e.toString();
      print("@@@@@@@@@@@@@@@");
      print(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> submitTodayAttendance({required String status}) async {
    final date = DateTime.now().toIso8601String().split("T").first;

    try {
      String? token = await TokenManager.getToken();
      final result = await _profileServises.submitAttendance(
        token: token!,
        status: status,
        date: date,
      );

      if (result) {
        // Optional: handle local update or fetch again
        // await loadAttendance();
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }
}
