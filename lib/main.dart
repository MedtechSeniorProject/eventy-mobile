import 'package:eventy_mobile/features/features.dart';
import 'package:eventy_mobile/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider(create: (_) => ScanProvider()),
        ChangeNotifierProvider(create: (_) => AddAttendeeProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.orange,
          textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: AppColors.accent,
            cursorColor: Colors.black,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {
          "/login": (_) => const LoginScreen(),
          "/scan": (_) => const ScanScreen(),
          "/add": (_) => const AddManuallyScreen(),
          "/details": (_) => const DetailsScreen(),
          "/forgot": (context) => const ForgotPasswordScreen(),
        },
      ),
    );
  }
}
