import 'package:eventy_mobile/features/auth/models/desk_agent_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  DeskAgentModel _deskAgent = DeskAgentModel();

  DeskAgentModel get deskAgent => _deskAgent;

  void setUser(DeskAgentModel deskAgent) {
    _deskAgent = deskAgent;
    notifyListeners();
  }
}
