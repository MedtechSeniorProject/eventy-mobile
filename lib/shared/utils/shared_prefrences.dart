import 'package:eventy_mobile/features/auth/models/desk_agent_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// We will use the shared_preferences package to store user's data locally

class UserPreferences {
  Future<bool> saveDeskAgent(DeskAgentModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('userId', user.deskAgent!.id!);
    prefs.setString('userName', user.deskAgent!.username!);
    prefs.setString('eventName', user.deskAgent!.event!.name!);

    return prefs.commit();
  }

  Future<DeskAgent> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userId = prefs.getString("userId");
    String? name = prefs.getString("userName");
    String? event = prefs.getString("event");

    return DeskAgent(
      id: userId,
      username: name,
      //TOFIX
      // event: event,
    );
  }
}
