import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/authentication/auth_screen.dart';
import 'package:foodpanda_users_app/authentication/login.dart';
import 'package:foodpanda_users_app/global/global.dart';
import 'package:foodpanda_users_app/mainScreens/home_screen.dart';

import '../mainScreens/InitialScreen.dart';
class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);
  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer(){
    Timer(const Duration(seconds: 3), () async
    {
      if(firebaseAuth.currentUser!=null)
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> InitialScreen()));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (c)=> WillPopScope(child: LoginScreen(), onWillPop: () async {return false;})),);
      }
    });
  }
  void initState(){
    super.initState();
    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
           colors: [
             Colors.white,
             Colors.grey.shade400,
           ],
           begin: FractionalOffset(1.0, 0.0),
           end: FractionalOffset(1.0, 1.0),
           stops: [0.0, 1.0],
           tileMode: TileMode.clamp,
         ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child:  Image.asset(
                    "images/IconoSplashScreen.png",
                    width: 150,
                    height: 150),
              ),
              const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "Order Food Online with 2SL.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    letterSpacing: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}