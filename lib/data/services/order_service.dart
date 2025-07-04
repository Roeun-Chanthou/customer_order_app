import 'dart:convert';

import 'package:customer_order_app/core/utils/app_constant.dart';
import 'package:http/http.dart' as http;

class OrderService {
  static Future<Map<String, dynamic>> placeOrder({
    required int customerId,
    required List<Map<String, dynamic>> items,
  }) async {
    final url = Uri.parse('$baseUrl/orders/place');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'customer_id': customerId,
          'items': items,
        }),
      );
      if (response.statusCode == 200) {
        return {'success': true, 'data': jsonDecode(response.body)};
      } else {
        return {'success': false, 'message': response.body};
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  static Future<List<dynamic>> getOrderHistory(int customerId) async {
    final url = Uri.parse('$baseUrl/orders/customer/$customerId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<Map<String, dynamic>?> getOrderDetail(int orderId) async {
    final url = Uri.parse('$baseUrl/orders/$orderId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
