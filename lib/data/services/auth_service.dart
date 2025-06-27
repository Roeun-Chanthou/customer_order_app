import 'dart:convert';
import 'dart:math';

import 'package:customer_order_app/core/utils/app_constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<Map<String, dynamic>> setupAccount({
    required String fullName,
    required String email,
    required String gender,
    required String phone,
    String? photo,
  }) async {
    var url = Uri.parse('$baseUrl/customer/setup');
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'full_name': fullName,
          'email': email,
          'gender': gender,
          'phone': phone,
          'photo': photo,
        }),
      );

      Map<String, dynamic> responseData;
      try {
        responseData = jsonDecode(response.body);
      } catch (e) {
        return {
          'success': false,
          'error': 'Invalid response format: Unable to parse server response'
        };
      }

      print('Full backend response: $responseData');

      final message =
          (responseData['message'] ?? responseData['msg'] ?? '').toLowerCase();
      final isSuccess = (responseData['status'] == true) ||
          message.contains('success') ||
          message.contains('successful');

      if (response.statusCode == 200 && isSuccess) {
        dynamic userId;
        if (responseData.containsKey('data')) {
          if (responseData['data'] is Map) {
            userId = responseData['data']['cid'];
          }
        }
        return {
          'success': true,
          'message': responseData['message'] ??
              responseData['meessage'] ??
              'Signup successful',
          'userId': userId,
          'data': responseData['data'],
        };
      } else {
        String errorMessage = responseData['message'] ??
            responseData['msg'] ??
            responseData['meessage'] ??
            // Add this block to handle Laravel validation errors:
            (responseData['errors'] != null
                ? responseData['errors']
                    .entries
                    .map((e) => '${e.key}: ${(e.value as List).join(', ')}')
                    .join('\n')
                : 'Signup failed');
        return {
          'success': false,
          'error': errorMessage,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error',
      };
    }
  }

  static Future<Map<String, dynamic>> sentOtp(String email) async {
    var url = Uri.parse('$baseUrl/user/sendOTP');
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
        }),
      );
      try {
        if (response.body.isNotEmpty) {
          Map<String, dynamic> responseData = jsonDecode(response.body);

          if (response.statusCode == 200 && responseData['status'] == true) {
            return {
              'success': true,
              'message': responseData['message'] ?? 'OTP sent successfully',
            };
          } else {
            return {
              'success': false,
              'error': responseData['message'] ?? 'Failed to send OTP',
            };
          }
        } else {
          return {
            'success': false,
            'error': 'Empty response from server',
          };
        }
      } catch (parseError) {
        if (response.statusCode == 200) {
          return {
            'success': true,
            'message': 'OTP sent successfully (non-JSON response)',
          };
        } else {
          return {
            'success': false,
            'error':
                'Invalid response format: ${response.body.substring(0, min(100, response.body.length))}...',
          };
        }
      }
    } catch (e) {
      return {'success': false, 'error': 'message'};
    }
  }

  static Future<Map<String, dynamic>> verifyUser(
    String email,
    String otp,
  ) async {
    var url = Uri.parse('$baseUrl/customer/verify');
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'otp': otp,
        }),
      );

      if (response.headers['content-type']?.contains('application/json') ==
          true) {
        var responseData = jsonDecode(response.body);
        print('Raw backend response: $responseData');

        bool isSuccess = false;
        if ((responseData['message'] ?? '')
            .toLowerCase()
            .contains('verified')) {
          isSuccess = true;
        }

        if (response.statusCode == 200 && isSuccess) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          if (responseData['data'] != null) {
            await prefs.setString('userData', jsonEncode(responseData['data']));
          }

          return {
            'success': true,
            'message': responseData['message'] ?? 'Verification successful',
            'data': responseData['data'],
          };
        } else {
          return {
            'success': false,
            'message': responseData['message'] ?? 'OTP not correct',
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Invalid response format',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'message',
      };
    }
  }

  static Future<Map<String, dynamic>> register(
    String email,
    String password,
  ) async {
    var url = Uri.parse('$baseUrl/customer/auth');
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.headers['content-type']?.contains('application/json') ==
          true) {
        var responseData = jsonDecode(response.body);

        if (response.statusCode == 200) {
          return {
            'success': true,
            'message': responseData['message'] ?? 'Registration successful',
            'userId': responseData['data']?['cid'],
            'data': responseData['data'],
          };
        } else {
          return {
            'success': false,
            'message': responseData['message'] ?? 'Registration failed',
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Invalid response format',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'message'};
    }
  }

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    var url = Uri.parse('$baseUrl/customer/login');

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.headers['content-type']?.contains('application/json') ==
          true) {
        var responseData = jsonDecode(response.body);

        if (response.statusCode == 200 && responseData.containsKey('data')) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('userData', jsonEncode(responseData['data']));
          int? userId = responseData['data']['cid'];

          return {
            'success': true,
            'message': responseData['message'],
            'userId': userId,
            'data': responseData['data'],
          };
        } else {
          return {
            'success': false,
            'message': responseData['message'] ?? 'Login failed',
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Invalid response format',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'message'};
    }
  }

  static Future<Map<String, dynamic>?> getSavedUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('userData');
    if (data != null) {
      return jsonDecode(data);
    }
    return null;
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('userData');
  }
}
