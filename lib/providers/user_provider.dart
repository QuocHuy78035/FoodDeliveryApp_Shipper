import 'package:ddnangcao_project/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  User _user = User();

  User get user => _user;

  void setUser(Map<String, dynamic> user){
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user){
    _user = user;
    notifyListeners();
  }
}

