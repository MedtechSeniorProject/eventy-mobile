import 'dart:developer';

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
  bool isFocused1 = false;
  bool isFocused2 = false;

  bool _isBoxShadowVisible = true;

  void tapDown() => setState(() {
        _isBoxShadowVisible = false;
      });

  void tapUp() => setState(() {
        _isBoxShadowVisible = true;
      });

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

                      Text("Hi, Welcome back!",
                          style: myBoldText(Dimensions.screenWidth! * 6)),
                      SizedBox(
                        height: Dimensions.screenHeight! * 5,
                      ),

                      /// Textfields
                      // using FocusScope to conditionally render the bottomRight Align widget
                      //TOFIX: focus logic error on first focus attempt ?? then it works fine
                      //ONE SOLUTION could be to create two isScrolling vars and assign each one to a textFormField
                      //---> that way there would be no conflict
                      FocusScope(
                        onFocusChange: (focus) {
                          setState(() {
                            isFocused1 = focus;
                          });
                          log("focus1: $focus");
                        },
                        child: MyCustomTextField(
                          title: 'Email',
                          controller: _username,
                          hint: 'Enter your username',
                        ),
                      ),
                      //
                      FocusScope(
                        onFocusChange: (focus) {
                          setState(() {
                            isFocused2 = focus;
                          });
                          log("focus2: $focus");
                        },
                        child: MyCustomTextField(
                          title: 'Password',
                          controller: _password,
                          hint: 'Enter your password',
                        ),
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
                                message: auth.resMessage, context: context);

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
                //TOFIX: focus
                if (!isFocused1 || !isFocused2)
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
