import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:portfolio_lms/Models/profileModel/get_attendance.dart';
import 'package:portfolio_lms/Models/profileModel/get_profile.dart';
import 'package:portfolio_lms/Utilities/api.dart';

class ProfileServises {
  Future<Profile> fetchProfile(String token, int userId) async {
    final response = await http.get(
      Uri.parse("$getProfileUrl$userId"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Profile.fromJson(data); // ✅ Parse single profile
    } else {
      throw Exception("Failed to load profile");
    }
  }

  Future<void> updateProfile(
    String name,
    String email,
    String phone,
    int userid,
    String token,
  ) async {
    final response = await http.put(
      Uri.parse("$updateProfileapi$userid"),
      body: json.encode({'name': name, 'email': email, 'phoneNumber': phone}),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update profile');
    }
  }

  Future<void> sendMedicalleave(
    DateTime date,
    String reason,

    String token,
  ) async {
    final response = await http.post(
      Uri.parse(sendMedicalLeave),
      body: json.encode({
        'leaveDate': date?.toIso8601String(),
        'reason': reason,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send request');
    }
  }

  Future<List<LeaveRequest>> getLeaveHistory(String token) async {
    final response = await http.get(
      Uri.parse(getLeaveStatus), // replace with your actual API
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> leaveList = data['leaveRequests'];
      return leaveList.map((e) => LeaveRequest.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch leave history");
    }
  }

  Future<Map<String, dynamic>> fetchAttendance(String token, int userid) async {
    final response = await http.get(
      Uri.parse("$getAttendanceHistory$userid"), // your actual endpoint here
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final attendanceResponse = AttendanceResponse.fromJson(jsonData);

      List<Attendance> attendanceList = attendanceResponse.attendance;
      int totalCount = attendanceResponse.attendanceCount;

      print("NOKK MYREEEEEEEEEEEEEEEEEEE22");
      return {'attendanceList': attendanceList, 'totalCount': totalCount};
    } else {
      throw Exception("Failed to fetch attendance data");
    }
  }

  Future<bool> submitAttendance({
    String? token,
    required String status,
    required String date,
  }) async {
    final response = await http.post(
      Uri.parse(markAttendance), // Replace with actual endpoint
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"status": status, "date": "2025-03-09"}),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to submit attendance");
    }
  }
}
