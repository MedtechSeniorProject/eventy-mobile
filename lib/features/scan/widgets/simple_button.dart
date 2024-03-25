import 'package:eventy_mobile/shared/constants/app_colors.dart';
import 'package:eventy_mobile/shared/shared.dart';
import 'package:flutter/material.dart';

class MySimpleButton extends StatelessWidget {
  MySimpleButton({super.key, this.tap, this.text, this.status, this.color});
  final VoidCallback? tap;
  bool? status = false;
  final Color? color;
  final String? text;
  @override
  Widget build(BuildContext context) {
    Dimensions(context);

    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.screenHeight! * 2),
      child: GestureDetector(
        onTap: status == true ? null : tap,
        child: Container(
          height: Dimensions.screenHeight! * 6,
          width: Dimensions.screenWidth! * 45,
          // margin: const EdgeInsets.only(bottom: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.black,
              width: 1,
            ),
            color: status == false ? color : AppColors.white,
          ),
          child: Text(
            status == false ? text! : 'Please wait...',
            style: myBoldText(Dimensions.screenHeight! * 2),
          ),
        ),
      ),
    );
  }
}
