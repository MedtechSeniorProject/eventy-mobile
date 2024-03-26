import 'package:eventy_mobile/shared/shared.dart';
import 'package:flutter/material.dart';

class MyCustomContainer extends StatelessWidget {
  const MyCustomContainer({super.key, required this.name, required this.email});

  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    Dimensions(context);
    return Container(
      height: Dimensions.screenHeight! * 15,
      width: Dimensions.screenWidth! * 70,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black, offset: Offset(-10, 10))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name: $name",
              style: myBoldText(Dimensions.screenHeight! * 2),
            ),
            Text(
              "Email: $email",
              style: myBoldText(Dimensions.screenHeight! * 2),
            ),
          ],
        ),
      ),
    );
  }
}
