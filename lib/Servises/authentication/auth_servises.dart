import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:portfolio_lms/Utilities/api.dart';

class AuthServices {
  Future<Map<String, dynamic>> registerStudent(
    String name,
    String email,
    String password,
    String role,
    String phonenumber,
  ) async {
    var url = Uri.parse(registrationUrl);

    try {
      var response = await https.post(
        url,
        headers: {'Content-Type': 'application/json'}, // Added headers
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'role': role,
          'phoneNumber': phonenumber,
        }),
      );

      final responseData = jsonDecode(response.body); // Decode response body
      print(responseData);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {"success": true, "message": responseData["message"]};
      } else if (response.statusCode == 400 || response.statusCode == 409) {
        return {"success": false, "message": responseData["message"]};
      } else {
        return {"success": false, "message": "Registration failed!"};
      }
    } catch (error) {
      return {"success": false, "message": "Network error! Please try again."};
    }
  }

  Future<Map<String, dynamic>> loginStudent(
    String email,
    String password,
  ) async {
    var url = Uri.parse(loginUrl);

    try {
      var response = await https.post(
        url,
        headers: {'Content-Type': 'application/json'}, // Added headers
        body: jsonEncode({'email': email, 'password': password}),
      );

      final responseData = jsonDecode(response.body); // Decode response body
      print(responseData);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "success": true,
          "token": responseData["token"],
          "userData": responseData["user"],
        };
      } else if (response.statusCode == 400 || response.statusCode == 409) {
        return {"success": false, "message": responseData["message"]};
      } else {
        return {"success": false, "message": "Registration failed!"};
      }
    } catch (error) {
      return {"success": false, "message": "Network error! Please try again."};
    }
  }
}
