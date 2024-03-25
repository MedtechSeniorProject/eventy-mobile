// ignore_for_file: must_be_immutable

import 'package:eventy_mobile/shared/shared.dart';
import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  MyCustomButton({super.key, this.isBoxShadowVisible, this.text, this.status});
  bool? status = false;
  final bool? isBoxShadowVisible;
  final String? text;

  @override
  Widget build(BuildContext context) {
    Dimensions(context);
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: Dimensions.screenHeight! * 5,
        width: Dimensions.screenWidth! * 45,
        margin: const EdgeInsets.symmetric(horizontal: 40),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: status == false ? AppColors.white : AppColors.white,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          boxShadow: isBoxShadowVisible!
              ? <BoxShadow>[
                  const BoxShadow(color: Colors.black, offset: Offset(-6, 6))
                ]
              : [],
        ),

        //text
        child: Text(
          status == false ? text! : 'Please wait...',
          style: myBoldText(Dimensions.screenHeight! * 2),
        ),
      ),
    );
  }
}
