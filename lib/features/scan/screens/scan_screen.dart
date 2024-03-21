import 'package:eventy_mobile/features/auth/providers/auth_provider.dart';
import 'package:eventy_mobile/features/auth/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
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
                  Text("Event ID: ${user.deskAgent.deskAgent?.event?.id}")
                ],
              ),
            );
          },
        ));
  }
}
