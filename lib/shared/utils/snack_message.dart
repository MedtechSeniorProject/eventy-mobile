import 'package:eventy_mobile/shared/constants/app_colors.dart';
import 'package:flutter/material.dart';

void showMessage(
    {required String message,
    required Color color,
    required IconData icon,
    BuildContext? context}) {
  ScaffoldMessenger.of(context!).showSnackBar(
    SnackBar(
      elevation: 0,
      backgroundColor: color.withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(5),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(icon),
          ),
          Text(
            message,
            style: const TextStyle(color: AppColors.black),
          ),
        ],
      ),
    ),
  );
}
