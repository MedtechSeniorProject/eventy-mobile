import 'dart:convert';
import 'dart:io';
import 'package:eventy_mobile/features/home/screens/scan_screen.dart';
import 'package:eventy_mobile/shared/utils/app_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'user_provider.dart';

class AuthenticationProvider extends ChangeNotifier {
  ///Setter
  bool _isLoading = false;
  String _resMessage = '';

  //Getter
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
        final res = json.decode(req.body);
        print("Successss");
        print(res);
        _isLoading = false;
        _resMessage = "Login successfull!";
        notifyListeners();

        ///Save deskagent id and then navigate to scan screen
        final userId = res['deskAgent']['id'];
        UserProvider().saveUserId(userId);

        Navigator.push(
          context!,
          MaterialPageRoute(builder: (context) => const ScanScreen()),
        );
      } else {
        final res = json.decode(req.body);

        _resMessage = res['message'];
        print("FAILLLLL");
        print(res);
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

  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }
}
