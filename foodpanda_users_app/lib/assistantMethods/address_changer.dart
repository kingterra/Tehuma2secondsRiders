import 'package:flutter/material.dart';

class AddressChanger extends ChangeNotifier
{
  int numeroDireccion = -1;
  int get count => numeroDireccion;

  displayResult(dynamic newValue)
  {
    numeroDireccion = newValue;
    notifyListeners();
  }
}