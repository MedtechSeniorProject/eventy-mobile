import 'package:eventy_mobile/shared/constants/app_colors.dart';
import 'package:flutter/material.dart';

void showMessage(
    {required String message,
    required Color color,
    IconData? icon,
    BuildContext? context}) {
  ScaffoldMessenger.of(context!).showSnackBar(
    SnackBar(
      elevation: 1,
      backgroundColor: color.withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(5),
      //TOFIX: use FlushBar instead of SnackBar
      content: Text(
        message,
        overflow: TextOverflow.fade,
        style: TextStyle(
            color:
                color == AppColors.success ? AppColors.white : AppColors.black),
      ),
    ),
  );
}
