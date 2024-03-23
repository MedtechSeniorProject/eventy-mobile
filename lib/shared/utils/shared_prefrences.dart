import 'dart:developer';

import 'package:eventy_mobile/features/auth/models/desk_agent_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
// We will use the shared_preferences package to store the users' data locally

class UserPreferences {
  //
  Future<bool> saveDeskAgent(DeskAgentModel deskAgentModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('userId', deskAgentModel.deskAgent!.id!);
    prefs.setString('userName', deskAgentModel.deskAgent!.username!);
    prefs.setString('eventId', deskAgentModel.deskAgent!.event!.id!);
    prefs.setString('eventName', deskAgentModel.deskAgent!.event!.name!);
    prefs.setString('accessToken', deskAgentModel.accessToken!);

    //for debugging , to remove
    log("shared prefrences");
    print("sharedddd: ${deskAgentModel.accessToken!}");
    return prefs.commit();
  }

  //
  Future<DeskAgentModel> getDeskAgent() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userId = prefs.getString("userId");
    String? username = prefs.getString("userName");
    String? eventId = prefs.getString("eventId");
    String? eventname = prefs.getString("eventName");
    String? accessToken = prefs.getString("accessToken");

    return DeskAgentModel(
      deskAgent: DeskAgent(
        id: userId,
        username: username,
        event: Event(
          id: eventId,
          name: eventname,
        ),
      ),
      accessToken: accessToken,
    );
  }

  //
  void clearPrefrences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
