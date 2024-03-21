import 'package:eventy_mobile/features/auth/providers/auth_provider.dart';
import 'package:eventy_mobile/features/auth/providers/user_provider.dart';
import 'package:eventy_mobile/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/splash/screens/splash_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            appBarTheme: AppBarTheme(
              color: AppColors.primary,
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: AppColors.primary),
            primaryColor: AppColors.primary),
        home: const SplashScreen(),
      ),
    );
  }
}
