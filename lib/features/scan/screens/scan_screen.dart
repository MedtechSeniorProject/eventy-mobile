// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:eventy_mobile/features/features.dart';
import 'package:eventy_mobile/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
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
      //for debugging, to pause camera
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     await controller?.pauseCamera();
      //   },
      // ),
      appBar: AppBar(
        leading: Transform.flip(
          flipX: true,
          child: IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.grey[850],
              ),
              onPressed: () {
                controller?.pauseCamera();
                AuthenticationProvider().logOut(context);
              }),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Scan Invite'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, user, child) {
          return Center(
            child: Stack(
              children: <Widget>[
                Align(
                    alignment: Alignment.center, child: _buildQrView(context)),
                //
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        EdgeInsets.only(bottom: Dimensions.screenHeight! * 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        //FOR Debugging to display scanned code value
                        // if (result != null)
                        //   Text(
                        //       'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                        // else
                        //   const Text('Scan a code'),

                        /////
                        Consumer<ScanProvider>(builder: (context, scan, child) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            //TOFIX: change showMessage according the resMessage value
                            if (scan.resMessage != '') {
                              showMessage(
                                message: scan.resMessage,
                                context: context,
                                color: AppColors.success,
                              );
                              scan.clear();
                            }
                          });
                          return MySimpleButton(
                            color: AppColors.secondary,
                            text: 'Scan Code',
                            tap: () async {
                              if (result!.code!.isEmpty) {
                                showMessage(
                                    message: "Invalid code",
                                    color: AppColors.success,
                                    icon: Icons.crisis_alert_sharp,
                                    context: context);
                              } else {
                                // await controller?.pauseCamera();
                                //@SAHAR: passing context is not the best practice --> try to optimize, sinon it works so...
                                //--> look into ChangeNotifierProxyProvider : bridge widget
                                scan.checkinAttendee(
                                  attendeeId: result!.code!,
                                  context: context,
                                );
                              }
                            },
                            status: scan.isLoading,
                          );
                        }),
                        MySimpleButton(
                          color: AppColors.white,
                          status: false,
                          text: 'Add Manually',
                          tap: () async {
                            await controller?.pauseCamera();
                            Navigator.pushNamed(context, "/add");
                          },
                        ),

                        /////
                        /////   TODO: default flash button --> TO DECIDE ON
                        // Container(
                        //   margin: const EdgeInsets.all(8),
                        //   child: ElevatedButton(
                        //       onPressed: () async {
                        //         await controller?.toggleFlash();
                        //         setState(() {});
                        //       },
                        //       child: FutureBuilder(
                        //         future: controller?.getFlashStatus(),
                        //         builder: (context, snapshot) {
                        //           return Text('Flash: ${snapshot.data}');
                        //         },
                        //       )),
                        // ),
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
    // For this example we check what the width or height of the device is and change the scanArea and overlay accordingly.
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
