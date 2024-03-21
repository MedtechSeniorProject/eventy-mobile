import 'dart:developer';

import 'package:eventy_mobile/features/auth/providers/user_provider.dart';
import 'package:eventy_mobile/features/auth/screens/login_screen.dart';
import 'package:eventy_mobile/features/scan/screens/scan_screen.dart';
import 'package:eventy_mobile/shared/utils/shared_prefrences.dart';
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
    return const Scaffold(
      body: Center(child: Image(image: AssetImage("assets/eventy.png"))),
    );
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      UserPreferences().getDeskAgent().then((value) {
        if (value.deskAgent!.id == null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
          //TODO: routing names
          // Navigator.pushNamed(context, '/login');
        } else {
          Provider.of<UserProvider>(context!, listen: false).setUser(value);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScanScreen()),
          );
        }
      });
    });
  }
}
