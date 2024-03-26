import 'package:eventy_mobile/features/scan/providers/scan_provider.dart';
import 'package:eventy_mobile/features/scan/widgets/custom_container.dart';
import 'package:eventy_mobile/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_symbols_icons/symbols.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Dimensions(context);
    return Consumer<ScanProvider>(
      builder: (context, scanProvider, child) {
        final attendeeName = scanProvider.attendeeResponseModel.name;
        final attendeeEmail = scanProvider.attendeeResponseModel.email;

        return Scaffold(
          appBar: AppBar(
            toolbarHeight: Dimensions.screenHeight! * 12,
            actions: [
              Image(
                image: const AssetImage(
                  "assets/details_topRight.png",
                ),
                fit: BoxFit.cover,
                width: Dimensions.screenWidth! * 20,
              )
            ],
          ),
          body: Stack(
            children: [
              //
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimensions.screenHeight! * 4),
                      child: Icon(
                        Symbols.check_circle,
                        color: AppColors.secondary,
                        size: Dimensions.screenHeight! * 8,
                      ),
                    ),
                    //
                    Text("Invite Scanned Sucessfully !",
                        style: myRegularText(Dimensions.screenWidth! * 5.5)),

                    //
                    Padding(
                      padding: EdgeInsets.only(
                          top: Dimensions.screenWidth! * 20,
                          bottom: Dimensions.screenWidth! * 8),
                      child: Text("Attendee Details",
                          style: myBoldText(Dimensions.screenWidth! * 5.5)),
                    ),
                    //

                    MyCustomContainer(
                        name: attendeeName!, email: attendeeEmail!),
                  ],
                ),
              ),
              //
              Align(
                alignment: Alignment.bottomLeft,
                child: Image(
                  image: const AssetImage(
                    "assets/details_bottomLeft.png",
                  ),
                  fit: BoxFit.cover,
                  width: Dimensions.screenWidth! * 25,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
