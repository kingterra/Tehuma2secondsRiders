import 'package:flutter/material.dart';

class ChangePaymentMethodText extends ChangeNotifier
{
  String? IDSeller = '';

  void ChangeText(dynamic newValue)
  {
    IDSeller = newValue;
    notifyListeners();
  }
}