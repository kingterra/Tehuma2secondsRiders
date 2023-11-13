import 'package:flutter/cupertino.dart';
import 'package:foodpanda_users_app/global/global.dart';

class CartItemCounter extends ChangeNotifier
{
  //total number of item in the cart list and we asign it to the int value
 int cartListItemCounter = sharedPreferences!.getStringList("userCart")!.length-1;
 int get count => cartListItemCounter;

 Future<void> displayCartListItemsNumber() async
 {
   cartListItemCounter = sharedPreferences!.getStringList("userCart")!.length-1;
   await Future.delayed(const  Duration(microseconds: 100), (){

     notifyListeners();

   });
 }


}