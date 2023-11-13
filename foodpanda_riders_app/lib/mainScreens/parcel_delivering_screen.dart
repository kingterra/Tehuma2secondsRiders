import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_riders_app/maps/map_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../assistantMethods/get_current_location.dart';
import '../global/global.dart';
import '../splashScreen/splash_screen.dart';


class ParcelDeliveringScreen extends StatefulWidget
{
  String? purchaserId;
  String? purchaserAddress;
  double? purchaserLat;
  double? purchaserLng;
  String? sellerUID;
  String? getOrderId;

  ParcelDeliveringScreen({
    this.purchaserId,
    this.purchaserAddress,
    this.purchaserLat,
    this.purchaserLng,
    this.sellerUID,
    this.getOrderId,
  });


  @override
  _ParcelDeliveringScreenState createState() => _ParcelDeliveringScreenState();
}




class _ParcelDeliveringScreenState extends State<ParcelDeliveringScreen>
{

String orderTotalAmount = "";
  /*confirmParcelHasBeenDelivere(getOrderId, sellerId, purchaserId, purchaserAddress, purchaserLat, purchaserLng)
  {

    String ridernewTotalEarningAmount = ((double.parse(previousRiderEarnings)) + (double.parse(perParcelDeliveryAmount))).toString();
    FirebaseFirestore.instance
        .collection("orders")
        .doc(getOrderId).update({
      "status": "ended",
      "address": completeAddress,
      "lat": position!.latitude,
      "lng": position!.longitude,
      "earnings": perParcelDeliveryAmount,//pay per parcel delivery amount
    }).then((value){
    FirebaseFirestore.instance
        .collection("riders")
        .doc(sharedPreferences!.getString("uid"))
        .update({
       "earnings": ridernewTotalEarningAmount,//total  earnings of specific riders
    });
    }).then((value) {

      FirebaseFirestore.instance
          .collection("sellers")
          .doc(widget.sellerId)
          .update({
        "earnings": (double.parse(orderTotalAmount) + (double.parse(previousEarnings))).toString(),//total  earnings amounnt of specific sellers
      });

    }).then((value){
      FirebaseFirestore.instance
          .collection("users")
          .doc(purchaserId)
          .collection("orders")
          .doc(getOrderId)
          .update({
        "status": "ended",
        "riderID": sharedPreferences!.getString("uid"),
      });
    });

    Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
  }*/

confirmParcelHasBeenDelivered(getOrderId, sellerId, purchaserId, purchaserAddress, purchaserLat, purchaserLng)
{
  
  String riderNewTotalEarningAmount = ((double.parse(previousRiderEarnings)) + (double.parse(perParcelDeliveryAmount))).toString();

  FirebaseFirestore.instance
      .collection("orders")
      .doc(getOrderId).update({
    "status": "ended",
    "address": completeAddress,
    "lat": position!.latitude,
    "lng": position!.longitude,
    "earnings": perParcelDeliveryAmount, //pay per parcel delivery amount
  }).then((value)
  {
    FirebaseFirestore.instance
        .collection("riders")
        .doc(sharedPreferences!.getString("uid"))
        .update(
        {
          "earnings": riderNewTotalEarningAmount, //total earnings amount of rider
        });
  }).then((value)
  {

      FirebaseFirestore.instance
          .collection("sellers")
          .doc(widget.sellerUID)
          .update(
          {
            "earnings": (double.parse(orderTotalAmount) + (double.parse(previousEarnings))).toString(), //total earnings amount of sellers
          });
    
  }).then((value)
  {
    FirebaseFirestore.instance
        .collection("users")
        .doc(purchaserId)
        .collection("orders")
        .doc(getOrderId).update(
        {
          "status": "ended",
          "riderUID": sharedPreferences!.getString("uid"),
        });
  });

  Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
}

  getOrderTotalAmount()
  {
    FirebaseFirestore.instance
        .collection("orders")
        .doc(widget.getOrderId)
        .get()
        .then((snap)
    {
      orderTotalAmount = snap.data()!["totalAmount"].toString();
      widget.sellerUID=  snap.data()!["sellerUID"].toString();
    }).then((value)
    {
      getSellerData();
    });
  }

  getSellerData()
  {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(widget.sellerUID)
        .get().then((snap)
    {
      previousEarnings = snap.data()!["earnings"].toString();
    });
  }

  @override
  void initState() {
    super.initState();

    UserLocation uLocation = UserLocation();
    uLocation.getCurrentLocation();

    getOrderTotalAmount();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Image.asset(
          "images/confirm2.png",
        ),

        const SizedBox(height: 5,),

        GestureDetector(
          onTap: ()
          {
            //show location from rider current location towards seller location
            MapUtils.launchMapFromSourceToDestination(position!.latitude, position!.longitude, widget.purchaserLat, widget.purchaserLng);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Image.asset(
                'images/restaurant.png',
                width: 50,
              ),

              const SizedBox(width: 7,),

              Column(
                children: const [
                  SizedBox(height: 12,),

                  Text(
                    "Show Delivery Drop-off Location",
                    style: TextStyle(
                      fontFamily: "Signatra",
                      fontSize: 18,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),

        const SizedBox(height: 40,),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: () {
              UserLocation uLocation = UserLocation();
              uLocation.getCurrentLocation();

              //confirmed - that rider has picked parcel from seller
              confirmParcelHasBeenDelivered(
                  widget.getOrderId,
                  widget.sellerUID,
                  widget.purchaserId,
                  widget.purchaserAddress,
                  widget.purchaserLat,
                  widget.purchaserLng
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.cyan,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 50.0,
              alignment: Alignment.center,
              child: Text(
                "Order has been delivered - Confirmed",
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          ),
        ),


      ],
    ),
    );
  }
}
