import 'package:flutter/material.dart';

class CustomSize {
  // Make properties static so they can be accessed without instance
  static late double screenWidth;
  static late double screenHeight;

  // Static method to initialize sizes
  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  // Helper methods for responsive sizes
  static double height(double height) {
    return screenHeight * (height / 812.0);
  }

  static double width(double width) {
    return screenWidth * (width / 375.0);
  }
}
