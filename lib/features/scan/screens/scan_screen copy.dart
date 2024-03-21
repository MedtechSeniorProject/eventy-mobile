import 'package:eventy_mobile/features/auth/providers/auth_provider.dart';
import 'package:eventy_mobile/features/auth/providers/user_provider.dart';
import 'package:eventy_mobile/features/auth/widgets/custom_button.dart';
import 'package:eventy_mobile/features/scan/providers/scan_provider.dart';
import 'package:eventy_mobile/shared/utils/snack_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String attendeeId = "19bb0839-1025-4028-822e-5bbf450d6569";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Scan Screen'),
          actions: [
            IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  AuthenticationProvider().logOut(context);
                }),
          ],
        ),
        body: Consumer<UserProvider>(
          builder: (context, user, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('User ID: ${user.deskAgent.deskAgent?.id}'),
                  Text("Event ID: ${user.deskAgent.deskAgent?.event?.id}"),

                  // ///Button
                  // Consumer<ScanProvider>(builder: (context, scan, child) {
                  //   WidgetsBinding.instance.addPostFrameCallback((_) {
                  //     if (scan.resMessage != '') {
                  //       showMessage(message: scan.resMessage, context: context);
                  //       scan.clear();
                  //     }
                  //   });
                  //   return customButton(
                  //     text: 'scan code',
                  //     tap: () {
                  //       if (attendeeId.isEmpty) {
                  //         showMessage(
                  //             message: "Invalid code", context: context);
                  //       } else {
                  //         scan.checkinAttendee(
                  //           attendeeId: attendeeId,
                  //           context: context,
                  //         );
                  //       }
                  //     },
                  //     context: context,
                  //     status: scan.isLoading,
                  //   );
                  // }),
                  ///Button
                  Consumer<ScanProvider>(builder: (context, scan, child) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (scan.resMessage != '') {
                        showMessage(message: scan.resMessage, context: context);
                        scan.clear();
                      }
                    });
                    return customButton(
                      text: 'scan code',
                      tap: () {
                        if (attendeeId.isEmpty) {
                          showMessage(
                              message: "Invalid code", context: context);
                        } else {
                          scan.checkinAttendee(
                            attendeeId: attendeeId,
                            context: context,
                          );
                        }
                      },
                      context: context,
                      status: scan.isLoading,
                    );
                  }),
                ],
              ),
            );
          },
        ));
  }
}
