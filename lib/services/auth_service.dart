import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/RegisterModel.dart';

class AuthService {
  // Base URL for API
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Register user
  Future<Map<String, dynamic>> register(User user) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(user.toJson()),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': 'Registration successful',
          'data': data,
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Registration failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred. Please try again.',
      };
    }
  }

  // Login user
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        // Save token or user data to local storage here
        return {
          'success': true,
          'message': 'Login successful',
          'data': data,
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Invalid credentials',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred. Please try again.',
      };
    }
  }
}
