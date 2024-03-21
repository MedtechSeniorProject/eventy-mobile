import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:eventy_mobile/features/auth/providers/user_provider.dart';
import 'package:eventy_mobile/features/scan/models/attendee_response_model.dart';
import 'package:eventy_mobile/features/scan/screens/details_screen.dart';
import 'package:eventy_mobile/shared/utils/app_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ScanProvider extends ChangeNotifier {
  //NOTE: should NOT need bearer token to checkin attendee since no token is returned for deskagents
  final token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzZXNzaW9uS2V5IjoiODI4NmVkM2YtMzlhMi00ZDdmLWFhYWUtZmY4NzUzMjVkODg5IiwidXNlcklkIjoiOWIxOGVkY2QtMGYyNi00Nzk2LWI3MWMtMGVkMTdjZjE0NGQ4Iiwicm9sZSI6ImV2ZW50bWFuYWdlciIsImlhdCI6MTcxMDk5MDI3NiwiZXhwIjoxNzExMDc2Njc2fQ.HhRm8hrLyM49U4wfLut7D3Lt-dK1eEzKe7WuJ7P4uaM";

  ///Setters
  bool _isLoading = false;
  String _resMessage = '';
  AttendeeResponseModel _attendeeResponseModel = AttendeeResponseModel();

  //Getters
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;
  AttendeeResponseModel get attendeeResponseModel => _attendeeResponseModel;

  //Checkin
  void checkinAttendee({
    required String attendeeId,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final eventID = userProvider.deskAgent.deskAgent!.event!.id;
    final body = {"attendeeId": attendeeId};

    try {
      http.Response req = await http.patch(Uri.parse(AppUrl.scan + eventID!),
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
        _resMessage = "checkin successfull!";

        // now we will create a attendee response model
        AttendeeResponseModel attendeeResponseModel =
            AttendeeResponseModel.fromJson(res);

        attendeeResponseModel = attendeeResponseModel;
        notifyListeners();
        setAttendeeDetails(attendeeResponseModel);

        Navigator.push(context!,
            MaterialPageRoute(builder: (context) => const DetailsScreen()));
      } else {
        //for debugging, to remove
        log("FAILLLLL");
        final res = json.decode(req.body);
        final resString = res.toString();
        log(resString);

        _resMessage = res['message'];

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
