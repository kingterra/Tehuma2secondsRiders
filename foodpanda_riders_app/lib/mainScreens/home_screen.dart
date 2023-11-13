import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_riders_app/authentication/auth_screen.dart';
import 'package:foodpanda_riders_app/global/global.dart';
import 'package:foodpanda_riders_app/mainScreens/not_yet_delivered_screen.dart';
import 'package:foodpanda_riders_app/mainScreens/parcel_in_progess_screen.dart';

import 'package:url_launcher/url_launcher.dart';

import '../assistantMethods/get_current_location.dart';
import 'earnings_screen.dart';
import 'history_screen.dart';
import 'new_orders_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  Card makeDashboardItem(String title, IconData iconData, int index) {
    List<Color> gradientColors;
    if (index == 0 || index == 3 || index == 4) {
      gradientColors = [Colors.blue, Colors.green];
    } else {
      gradientColors = [Colors.orange, Colors.red];
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: InkWell(
          onTap: () {
            // Handle item tap
            if (index == 0) {
              // New available orders
              Navigator.push(context, MaterialPageRoute(builder: (c)=> NewOrdersScreen()));
            } else if (index == 1) {
              // Parcels in progress
              Navigator.push(context, MaterialPageRoute(builder: (c)=> ParcelInProgressScreen()));
            } else if (index == 2) {
              // Not yet delivered
              Navigator.push(context, MaterialPageRoute(builder: (c)=> NotYetDeliveredScreen()));
            } else if (index == 3) {
              // History
              Navigator.push(context, MaterialPageRoute(builder: (c)=> HistoryScreen()));
            } else if (index == 4) {
              // Total earning
              Navigator.push(context, MaterialPageRoute(builder: (c)=> EarningsScreen()));
            } else if (index == 5) {
              // Logout
              firebaseAuth.signOut().then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (c) => const AuthScreen()),
                );
              });
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 40,
                color: Colors.white,
              ),
              const SizedBox(height: 10.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    UserLocation uLocation = UserLocation();
    uLocation!.getCurrentLocation();
    getPerParcelDeliveryAmount();
    getRiderPreviousEarnings();
  }

  getRiderPreviousEarnings()
  {
    FirebaseFirestore.instance
        .collection("riders")
        .doc(sharedPreferences!.getString("uid"))
        .get().then((snap)
    {
      previousRiderEarnings = snap.data()!["earnings"].toString();
    });
  }

  getPerParcelDeliveryAmount() {
    FirebaseFirestore.instance
        .collection("perDelivery")
        .doc("alizeb438")
        .get()
        .then((snap) {
      final amount = snap.data()?["amount"];
      if (amount != null && amount is num) {
        perParcelDeliveryAmount = amount.toString();
      } else {
        // Handle the case where the value is null or not a number.
        print("El valor de perParcelDeliveryAmount no es válido.");
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Welcome, " + sharedPreferences!.getString("name")!,
          style: const TextStyle(
            fontSize: 25.0,
            color: Colors.white,
            fontFamily: "Signatra",
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            makeDashboardItem("New Available Orders", Icons.shopping_bag, 0),
            makeDashboardItem("Parcels in Progress", Icons.delivery_dining, 1),
            makeDashboardItem("Not Yet Delivered", Icons.timer, 2),
            makeDashboardItem("History", Icons.history, 3),
            makeDashboardItem("Total Earning", Icons.attach_money, 4),
            makeDashboardItem("Logout", Icons.logout, 5),

            // Add the button to launch Flutter website URL

          ],
        ),
      ),
    );
  }
}
