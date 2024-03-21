import 'package:eventy_mobile/features/scan/providers/scan_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScanProvider>(
      builder: (context, scanProvider, child) {
        final attendeeName = scanProvider.attendeeResponseModel.name;
        final attendeeEmail = scanProvider.attendeeResponseModel.email;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Details Screen'),
          ),
          body: Center(
            child: Column(
              children: [
                Text('Hello, $attendeeName'),
                Text('Email: $attendeeEmail'),
              ],
            ),
          ),
        ); // Access user name from UserProvider
      },
    );
  }
}
