import 'package:eventy_mobile/shared/constants/app_colors.dart';
import 'package:flutter/material.dart';

//STYLE: to fix snack message style
void showMessage({String? message, BuildContext? context}) {
  ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
      content: Text(
        message!,
        style: TextStyle(color: AppColors.black),
      ),
      backgroundColor: AppColors.primary.withOpacity(0.4)));
}
