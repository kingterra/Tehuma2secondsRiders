import 'package:flutter/cupertino.dart';

class ChangeSelected extends ChangeNotifier{
  int selectedValued = 0;

  void ChangeNumber(int newValue){
    selectedValued = newValue;
    notifyListeners();
  }
}