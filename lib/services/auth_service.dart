import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/user.dart';

class AuthService {
  final String baseUrl = dotenv.env['API_URL'] ?? '';
  User? currentUser;

  // Login method
  Future<User> login(String email, String password) async {
    try {
      // Login directly with email and password
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          currentUser = User.fromJson(data['user']);
          return currentUser!;
        } else {
          throw Exception(data['message'] ?? 'Login failed');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Invalid email or password');
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // Register method
  Future<User> register({
    required String name,
    required String email,
    required String password,
    required String address,
    required String dob,
    required String phone,
    String? gender,
  }) async {
    try {
      // Register new user
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'name': name,
          'email': email,
          'password':
              password, // Send plain password, Laravel will handle bcrypt hashing
          'address': address,
          'dob': dob,
          'phone': phone,
          'gender': gender,
        }),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return User.fromJson(data['user']);
        } else {
          throw Exception(data['message'] ?? 'Registration failed');
        }
      } else if (response.statusCode == 422) {
        final data = json.decode(response.body);
        throw Exception(data['message'] ?? 'Validation failed');
      } else {
       
       throw Exception('Registration failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  // Verify email
  Future<bool> verifyEmail(String email, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/verify-email'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'email': email,
          'token': token,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['success'] == true;
      } else {
        throw Exception('Failed to verify email');
      }
    } catch (e) {
      throw Exception('Email verification failed: $e');
    }
  }

  // Request password reset
  Future<bool> requestPasswordReset(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/forgot-password'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['success'] == true;
      } else {
        throw Exception('Failed to request password reset');
      }
    } catch (e) {
      throw Exception('Password reset request failed: $e');
    }
  }

  // Reset password
  Future<bool> resetPassword({
    required String email,
    required String token,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/reset-password'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'email': email,
          'token': token,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['success'] == true;
      } else {
        throw Exception('Failed to reset password');
      }
    } catch (e) {
      throw Exception('Password reset failed: $e');
    }
  }

  // Change password
  Future<bool> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/change-password'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'email': email,
          'current_password': currentPassword,
          'new_password': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['success'] == true;
      } else {
        throw Exception('Failed to change password');
      }
    } catch (e) {
      throw Exception('Password change failed: $e');
    }
  }
}
