import 'package:customer_order_app/data/models/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static String baseUrl = "http://127.0.0.1:8000/api";

  static Future<List<ProductModel>> getAllProduct() async {
    var url = "$baseUrl/products";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return compute(productModelFromJson, response.body);
      }
      throw Exception('');
    } catch (e) {
      print(e);
      throw Exception('Failed to load products');
    }
  }
}
