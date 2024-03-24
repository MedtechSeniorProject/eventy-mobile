import 'dart:developer';
import 'dart:io';

import 'package:eventy_mobile/features/add_manually/screens/add_manually_screen.dart';
import 'package:eventy_mobile/features/auth/providers/auth_provider.dart';
import 'package:eventy_mobile/features/auth/providers/user_provider.dart';
import 'package:eventy_mobile/features/auth/widgets/custom_button.dart';
import 'package:eventy_mobile/features/scan/providers/scan_provider.dart';
import 'package:eventy_mobile/shared/utils/snack_message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  // String attendeeId = "19bb0839-1025-4028-822e-5bbf450d6569";
//
  Barcode? result;
  late dynamic test;
  String? guestData;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Screen'),
        actions: [
          IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                controller?.pauseCamera();
                AuthenticationProvider().logOut(context);
              }),
        ],
      ),
      body: Consumer<UserProvider>(
        builder: (context, user, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(flex: 4, child: _buildQrView(context)),
                Expanded(
                  flex: 1,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        if (result != null)
                          Text(
                              'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                        else
                          const Text('Scan a code'),

                        //TOFIX: default flash and flip camera buttons --> TO DECIDE ON
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: <Widget>[
                        //     Container(
                        //       margin: const EdgeInsets.all(8),
                        //       child: ElevatedButton(
                        //           onPressed: () async {
                        //             await controller?.toggleFlash();
                        //             setState(() {});
                        //           },
                        //           child: FutureBuilder(
                        //             future: controller?.getFlashStatus(),
                        //             builder: (context, snapshot) {
                        //               return Text('Flash: ${snapshot.data}');
                        //             },
                        //           )),
                        //     ),
                        //     Container(
                        //       margin: const EdgeInsets.all(8),
                        //       child: ElevatedButton(
                        //           onPressed: () async {
                        //             await controller?.flipCamera();
                        //             setState(() {});
                        //           },
                        //           child: FutureBuilder(
                        //             future: controller?.getCameraInfo(),
                        //             builder: (context, snapshot) {
                        //               if (snapshot.data != null) {
                        //                 return Text(
                        //                     'Camera facing ${describeEnum(snapshot.data!)}');
                        //               } else {
                        //                 return const Text('loading');
                        //               }
                        //             },
                        //           )),
                        //     )
                        //   ],
                        // ),

                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                //consumer button
                                Consumer<ScanProvider>(
                                    builder: (context, scan, child) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    if (scan.resMessage != '') {
                                      showMessage(
                                          message: scan.resMessage,
                                          context: context);
                                      scan.clear();
                                    }
                                  });
                                  return SizedBox(
                                    width: 150,
                                    child: customButton(
                                      text: 'scan code',
                                      tap: () async {
                                        if (result!.code!.isEmpty) {
                                          showMessage(
                                              message: "Invalid code",
                                              context: context);
                                        } else {
                                          await controller?.pauseCamera();
                                          //@SAHAR: passing context is not the best practice --> try to optimize, sinon it works so...
                                          //--> look into ChangeNotifierProxyProvider : bridge widget
                                          scan.checkinAttendee(
                                            attendeeId: result!.code!,
                                            context: context,
                                          );
                                        }
                                      },
                                      context: context,
                                      status: scan.isLoading,
                                    ),
                                  );
                                }),

                                //
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      // await controller?.resumeCamera();
                                      await controller?.pauseCamera();
                                    },
                                    child: const Text('resume',
                                        style: TextStyle(fontSize: 20)),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.all(8),
                              child: ElevatedButton(
                                onPressed: () async {
                                  await controller?.pauseCamera();

                                  Navigator.push(
                                      context!,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AddManuallyScreen()));
                                },
                                child: const Text('Add Manually',
                                    style: TextStyle(fontSize: 20)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  //
  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    //TOFIX: replace all mediaQuery with Dimensions from app_sizes.dart
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

//
  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
    controller.pauseCamera();
    controller.resumeCamera();
  }

  //
  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

// @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
