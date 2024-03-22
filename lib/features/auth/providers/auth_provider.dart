import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:eventy_mobile/features/auth/models/desk_agent_model.dart';
import 'package:eventy_mobile/features/auth/providers/user_provider.dart';
import 'package:eventy_mobile/features/auth/screens/login_screen.dart';
import 'package:eventy_mobile/features/scan/screens/scan_screen.dart';
import 'package:eventy_mobile/shared/utils/app_url.dart';
import 'package:eventy_mobile/shared/utils/shared_prefrences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AuthenticationProvider extends ChangeNotifier {
  ///Setters
  bool _isLoading = false;
  String _resMessage = '';

  //Getters
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  //Login
  void loginUser({
    required String username,
    required String password,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    final body = {"username": username, "password": password};

    try {
      http.Response req = await http.post(Uri.parse(AppUrl.login),
          body: jsonEncode(body),
          headers: {"Content-Type": "application/json"});
      if (req.statusCode == 200 || req.statusCode == 201) {
        final Map<String, dynamic> res = json.decode(req.body);
        //for debugging, to remove
        log("Successss");
        print("response body : ${res.toString()}");
        _isLoading = false;
        _resMessage = "Login successfull!";

        // now we will create a deskagent model
        DeskAgentModel authUser = DeskAgentModel.fromJson(res);

        // save data to shared preferences
        UserPreferences().saveDeskAgent(authUser);
        notifyListeners();

        //setting the deskAgentModel from the UserProvider
        Provider.of<UserProvider>(context!, listen: false).setUser(authUser);

        Navigator.push(context!,
            MaterialPageRoute(builder: (context) => const ScanScreen()));
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

  void logOut(BuildContext context) async {
    UserPreferences().clearPrefrences();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void clear() {
    _resMessage = "";
    notifyListeners();
  }
}
