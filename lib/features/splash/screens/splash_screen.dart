import 'package:eventy_mobile/features/auth/providers/user_provider.dart';
import 'package:eventy_mobile/features/auth/screens/login_screen.dart';
import 'package:eventy_mobile/features/home/screens/scan_screen.dart';
import 'package:flutter/material.dart';

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
      body: Center(child: FlutterLogo()),
    );
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      UserProvider().getUserId().then((value) {
        if (value == '') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
          // Navigator.pushNamed(context, '/login');
          // PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScanScreen()),
          );
          // PageNavigator(ctx: context).nextPageOnly(page: const HomePage());
        }
      });
    });
  }
}
