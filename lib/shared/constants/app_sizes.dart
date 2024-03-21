import 'package:flutter/material.dart';

class Dimensions {
  static double? screenWidth;
  static double? screenHeight;

  Dimensions(context) {
    screenHeight = MediaQuery.of(context).size.height / 100;
    screenWidth = MediaQuery.of(context).size.width / 100;
  }
}
