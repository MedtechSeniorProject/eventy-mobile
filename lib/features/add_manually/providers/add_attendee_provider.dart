import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:eventy_mobile/features/auth/providers/user_provider.dart';
import 'package:eventy_mobile/features/scan/models/attendee_response_model.dart';
import 'package:eventy_mobile/shared/utils/app_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddAttendeeProvider extends ChangeNotifier {
  ///Setters
  bool _isLoading = false;
  String _resMessage = '';
  AttendeeResponseModel _attendeeResponseModel = AttendeeResponseModel();

  //Getters
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;
  AttendeeResponseModel get attendeeResponseModel => _attendeeResponseModel;

  //Login
  void AddAttendee({
    required String name,
    required String email,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final eventID = userProvider.deskAgent.deskAgent!.event!.id;
    final accessToken = userProvider.deskAgent.accessToken;

    final body = {"name": name, "email": email};

    try {
      http.Response req = await http.post(Uri.parse(AppUrl.scan + eventID!),
          body: jsonEncode(body),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $accessToken',
          });
      if (req.statusCode == 200 || req.statusCode == 201) {
        final Map<String, dynamic> res = json.decode(req.body);
        //for debugging, to remove
        log("Successss");
        print("response body : ${res.toString()}");
        _isLoading = false;
        _resMessage = "added attendee successfully!";
        notifyListeners();

        //TO either find a way to pass changeNotifier (provider) param to details screen (either scanProvider or addAttendeeProvider)
        // ----> or just stick to sucess alert dialog
        //      --> IF yes, remove below
        // // now we will create a attendee response model
        // AttendeeResponseModel attendeeResponseModel =
        //     AttendeeResponseModel.fromJson(res);

        // attendeeResponseModel = attendeeResponseModel;
        // notifyListeners();
        // setAttendeeDetails(attendeeResponseModel);

        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const DetailsScreen()));
      } else {
        final res = json.decode(req.body);
        _resMessage = res['message'];

        //for debugging, to remove
        log("FAILLLLL");
        log(accessToken!);
        log(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Please check your Internet connection";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again`";
      notifyListeners();

      print("SocketException:  $e");
    }
  }

  void setAttendeeDetails(AttendeeResponseModel attendeeResponseModel) {
    _attendeeResponseModel = attendeeResponseModel;
    notifyListeners();
  }

  void clear() {
    _resMessage = "";
    notifyListeners();
  }
}
