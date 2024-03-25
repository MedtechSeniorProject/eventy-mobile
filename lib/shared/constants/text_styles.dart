import 'package:eventy_mobile/shared/shared.dart';
import 'package:flutter/material.dart';

//style for all bold texts throughout the app
TextStyle myBoldText(double size) {
  return TextStyle(
    color: AppColors.black,
    fontSize: size,
    fontWeight: FontWeight.w500,
  );
}

//style for all regular texts throughout the app
TextStyle myRegularText(double size) {
  return TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w400,
    fontSize: size,
  );
}

TextStyle myHintText(double size) {
  return TextStyle(
    color: Colors.grey[400]!,
    fontWeight: FontWeight.w400,
    fontSize: size,
  );
}
