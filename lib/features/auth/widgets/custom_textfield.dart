import 'package:eventy_mobile/shared/constants/app_colors.dart';
import 'package:eventy_mobile/shared/constants/app_sizes.dart';
import 'package:eventy_mobile/shared/constants/text_styles.dart';
import 'package:flutter/material.dart';

class MyCustomTextField extends StatelessWidget {
  MyCustomTextField({
    super.key,
    this.title,
    this.hint,
    this.node,
    this.controller,
  });

  final String? title;
  final String? hint;
  final TextEditingController? controller;
  late FocusNode? node;
  final int? maxLines = 1;

  @override
  Widget build(BuildContext context) {
    Dimensions(context);
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(title!,
                style: myRegularText(Dimensions.screenWidth! * 3.5)),
          ),
          //
          Container(
            margin:
                EdgeInsets.symmetric(vertical: Dimensions.screenHeight! * 1.5),
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.black, width: 1.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              focusNode: node,
              controller: controller,
              maxLines: maxLines,
              decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: myHintText(Dimensions.screenWidth! * 3.5),
                  border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }
}
