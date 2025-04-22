import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:portfolio_lms/Models/get_profile.dart';
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
      print('--------------------------');
    final response = await http.put(
      Uri.parse("$updateProfileapi$userid"),
      body: json.encode({'name': name, 'email': email, 'phoneNumber': phone}),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print('"====================');
    print(response.body);
    if (response.statusCode != 200) {
      throw Exception('Failed to update profile');
    }
  }
}
