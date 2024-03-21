import 'package:eventy_mobile/features/auth/providers/auth_provider.dart';
import 'package:eventy_mobile/features/auth/widgets/custom_textfield.dart';
import 'package:eventy_mobile/shared/utils/snack_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _username.clear();
    _password.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Login"),
                customTextField(
                  title: 'username',
                  controller: _username,
                  hint: 'Enter your username',
                ),
                customTextField(
                  title: 'Password',
                  controller: _password,
                  hint: 'Enter your password',
                ),

                ///Button
                Consumer<AuthenticationProvider>(
                    builder: (context, auth, child) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (auth.resMessage != '') {
                      showMessage(message: auth.resMessage, context: context);

                      ///Clear the response message to avoid duplicate
                      auth.clear();
                    }
                  });
                  return customButton(
                    text: 'Login',
                    tap: () {
                      if (_username.text.isEmpty || _password.text.isEmpty) {
                        showMessage(
                            message: "All fields are required",
                            context: context);
                      } else {
                        auth.loginUser(
                            context: context,
                            username: _username.text.trim(),
                            password: _password.text.trim());
                      }
                    },
                    context: context,
                    status: auth.isLoading,
                  );
                }),

                const SizedBox(
                  height: 10,
                ),
              ],
            )));
  }
}
