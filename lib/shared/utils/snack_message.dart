import 'package:eventy_mobile/shared/constants/app_colors.dart';
import 'package:flutter/material.dart';

void showMessage({String? message, BuildContext? context}) {
  ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
      content: Text(
        message!,
        style: TextStyle(color: AppColors.accent),
      ),
      backgroundColor: AppColors.primary));
}
