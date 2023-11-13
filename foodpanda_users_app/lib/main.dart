import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodpanda_users_app/assistantMethods/cart_Item_Counter.dart';
import 'package:foodpanda_users_app/global/global.dart';
import 'package:foodpanda_users_app/splashScreen/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'assistantMethods/PassSellerID.dart';
import 'assistantMethods/addressIDchanger.dart';
import 'assistantMethods/address_changer.dart';
import 'assistantMethods/total_amount.dart';
import 'assistantMethods/change_selected.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp,DeviceOrientation.portraitDown])
      .then((_) => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       ChangeNotifierProvider(create: (c)=> CartItemCounter()),
       ChangeNotifierProvider(create: (c)=> TotalAmount()),
       ChangeNotifierProvider(create: (c)=> AddressChanger()),
       ChangeNotifierProvider(create: (c)=>ChangeSelected()),
       ChangeNotifierProvider(create: (c)=>AddressIDChanger()),
       ChangeNotifierProvider(create: (c)=>PassSellerID()),
      ],
      child: MaterialApp(
        title: 'users app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          //primaryColor: Colors.black,
          textTheme: /*GoogleFonts.openSansTextTheme(
              Theme.of(context).textTheme,
          ) */TextTheme(
            bodyMedium: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans'
            )
          ),
        ),
        home: const MySplashScreen(),
      ),
    );
  }
}


