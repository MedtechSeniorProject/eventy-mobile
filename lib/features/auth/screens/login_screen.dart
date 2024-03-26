import 'package:eventy_mobile/features/auth/providers/auth_provider.dart';
import 'package:eventy_mobile/features/auth/widgets/custom_textfield.dart';
import 'package:eventy_mobile/shared/shared.dart';
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
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _isBoxShadowVisible = true;

  @override
  void dispose() {
    _username.clear();
    _password.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Dimensions(context);

    return Container(
      color: AppColors.white,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.white,
            body: Stack(
              children: [
                //topLeft
                Align(
                  alignment: Alignment.topLeft,
                  child: Image(
                    image: const AssetImage("assets/login_topLeft.png"),
                    fit: BoxFit.cover,
                    width: Dimensions.screenWidth! * 25,
                  ),
                ),

                //form
                SingleChildScrollView(
                  padding: EdgeInsets.only(
                    top: Dimensions.screenHeight! * 12,
                    left: Dimensions.screenWidth! * 14,
                    right: Dimensions.screenWidth! * 14,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //logo
                      Center(
                        child: Image(
                          image: const AssetImage("assets/eventy_small.png"),
                          fit: BoxFit.cover,
                          width: Dimensions.screenWidth! * 24,
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight! * 8,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("Hi, Welcome back!",
                            style: myBoldText(Dimensions.screenWidth! * 6)),
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight! * 5,
                      ),

                      MyCustomTextField(
                        node:
                            _emailFocusNode, // focusNode to conditionally render the bottomRight widget
                        title: 'Email',
                        controller: _username,
                        hint: 'Enter your username',
                      ),
                      //
                      MyCustomTextField(
                        node: _passwordFocusNode,
                        title: 'Password',
                        controller: _password,
                        hint: 'Enter your password',
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight! * 5,
                      ),

                      ///Button
                      Consumer<AuthenticationProvider>(
                          builder: (context, auth, child) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (auth.resMessage != '') {
                            showMessage(
                              message: auth.resMessage,
                              context: context,
                              color: AppColors.success,
                            );

                            ///Clear the response message to avoid duplicate
                            auth.clear();
                          }
                        });
                        return GestureDetector(
                          //
                          onTapDown: (details) => setState(() {
                            _isBoxShadowVisible = false;
                            if (_username.text.isEmpty ||
                                _password.text.isEmpty) {
                              showMessage(
                                  message: "All fields are required",
                                  color: AppColors.error,
                                  icon: Icons.priority_high_rounded,
                                  context: context);
                            } else {
                              auth.loginUser(
                                  context: context,
                                  username: _username.text.trim(),
                                  password: _password.text.trim());
                            }
                          }),
                          //
                          onTapUp: (details) => setState(() {
                            _isBoxShadowVisible = true;
                          }),
                          //
                          child: MyCustomButton(
                            isBoxShadowVisible: _isBoxShadowVisible,
                            text: 'Login',
                            status: auth.isLoading,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                if (!_passwordFocusNode.hasFocus && !_emailFocusNode.hasFocus)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image(
                      image: const AssetImage(
                        "assets/splash_bottomRight.png",
                      ),
                      fit: BoxFit.cover,
                      width: Dimensions.screenWidth! * 25,
                    ),
                  ),
              ],
            )),
      ),
    );
  }
}
