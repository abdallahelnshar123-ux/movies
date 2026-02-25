import 'package:flutter/material.dart';

import '../model/my_user.dart';

class UserProvider extends ChangeNotifier{
  //todo: data
  MyUser? currentUser;

  void updateUser(MyUser newUser){
    currentUser = newUser;
    notifyListeners();
  }
}