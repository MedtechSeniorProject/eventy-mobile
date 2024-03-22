import 'package:eventy_mobile/features/add_manually/providers/add_attendee_provider.dart';
import 'package:eventy_mobile/features/auth/widgets/custom_button.dart';
import 'package:eventy_mobile/features/auth/widgets/custom_textfield.dart';
import 'package:eventy_mobile/shared/utils/snack_message.dart';
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

  @override
  void dispose() {
    _name.clear();
    _email.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Manually'),
        ),
        body: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("add attendee manually"),
                customTextField(
                  title: 'name',
                  controller: _name,
                  hint: 'Enter name',
                ),
                customTextField(
                  title: 'email',
                  controller: _email,
                  hint: 'Enter  email',
                ),

                ///Button
                Consumer<AddAttendeeProvider>(
                    builder: (context, addattendee, child) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (addattendee.resMessage != '') {
                      showMessage(
                          message: addattendee.resMessage, context: context);

                      addattendee.clear();
                    }
                  });
                  return customButton(
                    text: 'Add',
                    tap: () {
                      if (_name.text.isEmpty || _email.text.isEmpty) {
                        showMessage(
                            message: "All fields are required",
                            context: context);
                      } else {
                        addattendee.AddAttendee(
                            context: context,
                            name: _name.text.trim(),
                            email: _email.text.trim());
                      }
                    },
                    context: context,
                    status: addattendee.isLoading,
                  );
                }),

                const SizedBox(
                  height: 10,
                ),
              ],
            )));
  }
}
