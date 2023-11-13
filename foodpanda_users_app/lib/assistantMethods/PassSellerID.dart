import 'package:flutter/material.dart';

class PassSellerID extends ChangeNotifier
{
  String? IDSeller = '';

  void PassID(dynamic newValue)
  {
    IDSeller = newValue;
    notifyListeners();
  }
}