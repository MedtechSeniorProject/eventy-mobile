import 'package:eventy_mobile/features/add_manually/providers/add_attendee_provider.dart';
import 'package:eventy_mobile/features/auth/widgets/custom_button.dart';
import 'package:eventy_mobile/features/auth/widgets/custom_textfield.dart';
import 'package:eventy_mobile/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddManuallyScreen extends StatefulWidget {
  const AddManuallyScreen({super.key});

  @override
  State<AddManuallyScreen> createState() => _AddManuallyScreenState();
}

class _AddManuallyScreenState extends State<AddManuallyScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  bool _isBoxShadowVisible = true;

  @override
  void dispose() {
    _name.clear();
    _email.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Dimensions(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Add Attendee'),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(
                top: Dimensions.screenHeight! * 10,
                left: Dimensions.screenWidth! * 14,
                right: Dimensions.screenWidth! * 14,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Insert Details",
                        style: myBoldText(Dimensions.screenWidth! * 6)),
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight! * 5,
                  ),

                  MyCustomTextField(
                    node: _nameFocusNode,
                    title: 'name',
                    controller: _name,
                    hint: 'Enter name',
                  ),

                  MyCustomTextField(
                    node: _emailFocusNode,
                    title: 'email',
                    controller: _email,
                    hint: 'Enter  email',
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight! * 8,
                  ),

                  //custom button
                  Consumer<AddAttendeeProvider>(
                      builder: (context, addattendee, child) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (addattendee.resMessage != '') {
                        showMessage(
                          message: addattendee.resMessage,
                          context: context,
                          color: AppColors.success,
                        );

                        ///Clear the response message to avoid duplicate
                        addattendee.clear();
                      }
                    });
                    return GestureDetector(
                      //
                      onTapDown: (details) => setState(() {
                        _isBoxShadowVisible = false;
                        if (_name.text.isEmpty || _email.text.isEmpty) {
                          showMessage(
                              color: AppColors.error,
                              message: "All fields are required",
                              context: context);
                        } else {
                          addattendee.AddAttendee(
                              context: context,
                              name: _name.text.trim(),
                              email: _email.text.trim());
                        }
                      }),
                      //
                      onTapUp: (details) => setState(() {
                        _isBoxShadowVisible = true;
                      }),
                      //
                      child: MyCustomButton(
                        isBoxShadowVisible: _isBoxShadowVisible,
                        text: 'Add Attendee',
                        status: addattendee.isLoading,
                      ),
                    );
                  }),
                ],
              ),
            ),
            if (!_nameFocusNode.hasFocus && !_emailFocusNode.hasFocus)
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
        ));
  }
}
