import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:eventy_mobile/features/auth/providers/user_provider.dart';
import 'package:eventy_mobile/features/scan/models/attendee_response_model.dart';
import 'package:eventy_mobile/shared/utils/app_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

//TEST , try again with connection

class AddAttendeeProvider extends ChangeNotifier {
  //TOREMOVE
  //NOTE: should NOT need bearer token to checkin attendee since no token is returned for deskagents
  final token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzZXNzaW9uS2V5IjoiNjRjYTVlYzAtOGIzZi00MTliLTliZmUtNjk3ZjhhZWNlZTI3IiwidXNlcklkIjoiOWIxOGVkY2QtMGYyNi00Nzk2LWI3MWMtMGVkMTdjZjE0NGQ4Iiwicm9sZSI6ImV2ZW50bWFuYWdlciIsImlhdCI6MTcxMTA5NjUzNSwiZXhwIjoxNzExMTgyOTM1fQ.K2lVJS5MR_THdZta-ansD4M1tOnDG632qW_ZMLB2TMA";

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

    final body = {"name": name, "email": email};

    try {
      http.Response req = await http.post(Uri.parse(AppUrl.scan + eventID!),
          body: jsonEncode(body),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token',
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
