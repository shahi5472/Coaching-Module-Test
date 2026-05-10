import 'package:flutter/material.dart';

import '../services/data/user/user_model.dart';

class ProfileService extends ChangeNotifier {
  UserModel _userModel = const UserModel();

  UserModel get user => _userModel;

  void setUser(UserModel user) {
    _userModel = user;

    notifyListeners();
  }
}
