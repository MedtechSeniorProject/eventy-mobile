import 'package:eventy_mobile/features/auth/providers/user_provider.dart';
import 'package:eventy_mobile/features/auth/screens/login_screen.dart';
import 'package:eventy_mobile/features/scan/screens/scan_screen.dart';
import 'package:eventy_mobile/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    Dimensions(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image(
                image: const AssetImage("assets/splash_topLeft.png"),
                fit: BoxFit.cover,
                width: Dimensions.screenWidth! * 40,
              ),
            ),
            const Center(child: Image(image: AssetImage("assets/eventy.png"))),
            Align(
              alignment: Alignment.bottomRight,
              child: Image(
                image: const AssetImage(
                  "assets/splash_bottomRight.png",
                ),
                fit: BoxFit.cover,
                width: Dimensions.screenWidth! * 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 2600), () {
      UserPreferences().getDeskAgent().then((value) {
        if (value.accessToken == null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
          //TOFIX: routing names
          // Navigator.pushNamed(context, '/login');
        } else {
          Provider.of<UserProvider>(context, listen: false).setUser(value);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScanScreen()),
          );
        }
      });
    });
  }
}
