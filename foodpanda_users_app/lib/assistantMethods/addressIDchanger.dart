import 'package:flutter/material.dart';

class AddressIDChanger extends ChangeNotifier
{
  String? IDChanger = '';

  void display(dynamic newValue)
  {
    IDChanger = newValue;
    notifyListeners();
  }
}