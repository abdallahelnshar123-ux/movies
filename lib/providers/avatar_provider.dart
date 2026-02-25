
import 'package:flutter/cupertino.dart';

class AvatarProvider extends ChangeNotifier{
  int selectedAvatarIndex = 0;

void changeAvatar(int index){
  selectedAvatarIndex = index;
  notifyListeners();
}
}