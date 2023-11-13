import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_riders_app/assistantMethods/get_current_location.dart';
import 'package:foodpanda_riders_app/global/global.dart';
import 'package:foodpanda_riders_app/mainScreens/parcel_delivering_screen.dart';
import 'package:foodpanda_riders_app/maps/map_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParcelPickingScreen extends StatefulWidget
{
  String? purchaserId;
  String? sellerUID;
  String? getOrderID;
  String? purchaserAddress;
  double? purchaserLat;
  double? purchaserLng;

  ParcelPickingScreen({
    this.purchaserId,
    this.sellerUID,
    this.getOrderID,
    this.purchaserAddress,
    this.purchaserLat,
    this.purchaserLng,
  });

  @override
  _ParcelPickingScreenState createState() => _ParcelPickingScreenState();
}



class _ParcelPickingScreenState extends State<ParcelPickingScreen>
{
  double? sellerLat, sellerLng;

  getSellerData() async
  {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(widget.sellerUID)
        .get()
        .then((DocumentSnapshot)
    {
         sellerLat = DocumentSnapshot.data()!["lat"];
         sellerLng = DocumentSnapshot.data()!["lng"];
         // Print the seller coordinates after fetching from Firestore
         print('Seller Lat: $sellerLat');
         print('Seller Lng: $sellerLng');
    });
  }

  @override
  void initState() {
    super.initState();

    getSellerData();
  }

  confirmParcelHasBeenPicked(getOrderId, sellerUID, purchaserId, purchaserAddress, purchaserLat, purchaserLng)
  {
    FirebaseFirestore.instance
        .collection("orders")
        .doc(getOrderId).update({
      "status": "delivering",
      "address": completeAddress,
      "lat": position!.latitude,
      "lng": position!.longitude,
    });

    Navigator.push(context, MaterialPageRoute(builder: (c)=> ParcelDeliveringScreen(
      purchaserId: purchaserId,
      purchaserAddress: purchaserAddress,
      purchaserLat: purchaserLat,
      purchaserLng: purchaserLng,
      sellerUID: sellerUID,
      getOrderId: getOrderId,
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Expanded(  // Add Expanded here to make GoogleMap take up the remaining space
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(position?.latitude ?? 0, position?.longitude ?? 0),
                zoom: 15.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('riderMarker'),
                  position: LatLng(position?.latitude ?? 0, position?.longitude ?? 0),
                  infoWindow: InfoWindow(title: 'Rider Location'),
                ),
                Marker(
                  markerId: MarkerId('sellerMarker'),
                  position: LatLng(sellerLat ?? 0, sellerLng ?? 0),
                  infoWindow: InfoWindow(title: 'Seller Location'),
                ),
              },
              onTap: (LatLng point) {
                // Handle map tap if needed
                MapUtils.launchMapFromSourceToDestination(position!.latitude, position!.longitude, sellerLat, sellerLng);
              },
            ),
          ),


          const SizedBox(height: 5,),

          GestureDetector(
            onTap: ()
            {
              //show location from rider current location towards seller location
              MapUtils.launchMapFromSourceToDestination(position!.latitude, position!.longitude, sellerLat, sellerLng);
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
                      "Show Cafe/Restaurant Location",
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
                      confirmParcelHasBeenPicked(
                          widget.getOrderID,
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
                        "Order has been Picked - Confirmed",
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
