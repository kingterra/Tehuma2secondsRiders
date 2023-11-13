import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_riders_app/models/address.dart';
import 'package:foodpanda_riders_app/splashScreen/splash_screen.dart';

import '../assistantMethods/get_current_location.dart';
import '../global/global.dart';
import '../mainScreens/parcel_picking_screen.dart';


class ShipmentAddressDesign extends StatelessWidget {

  final Address? model;
  final String? orderStatus;
  final String? orderId;
  final String? sellerUID;
  final String? orderByUser;

  ShipmentAddressDesign({this.model, this.orderStatus, this.orderId, this.sellerUID, this.orderByUser});



  confirmedParcelShipment(BuildContext context, String getOrderID, String sellerId, String purchaserId)
  {
    print("positionLAT_Terra: ${position!.latitude}");
    print("positionLNG_Terra: ${position!.longitude}" );

    FirebaseFirestore.instance
        .collection("orders")
        .doc(getOrderID)
        .update({
      "riderUID": sharedPreferences!.getString("uid"),
      "riderName": sharedPreferences!.getString("name"),
      "status": "picking",
      "lat": position!.latitude,
      "lng": position!.longitude,
      "address": completeAddress,
    });

    //send rider to shipmentScreen
    Navigator.push(context, MaterialPageRoute(builder: (context) => ParcelPickingScreen(
      purchaserId: purchaserId,
      purchaserAddress: model!.fullAddress,
      purchaserLat: model!.lat,
      purchaserLng: model!.lng,
      sellerUID: sellerUID,
      getOrderID: getOrderID,
    )));
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Shipping Details:',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24.0),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name:",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  Text(model!.name!, style: TextStyle(fontSize: 16.0)),
                ],
              ),
              SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Phone Number:",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  Text(model!.phoneNumber!, style: TextStyle(fontSize: 16.0)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            model!.fullAddress!,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        orderStatus == "ended"
            ? Container()
            : Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: () {
              UserLocation uLocation = UserLocation();
              uLocation.getCurrentLocation();

              confirmedParcelShipment(context, orderId!, sellerUID!, orderByUser!);
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
                "Confirm - To Deliver this Parcel",
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MySplashScreen()));
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
                "Go Back",
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }
}
