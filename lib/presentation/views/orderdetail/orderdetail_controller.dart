import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderdetailController extends GetxController {
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return const Color(0xFF2ECC71);
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  String getImageUrl(String image) {
    if (image.isEmpty) return '';
    return image.startsWith('http') ? image : 'http://127.0.0.1:8000$image';
  }
}
