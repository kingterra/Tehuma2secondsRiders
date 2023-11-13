

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodpanda_users_app/global/global.dart';
import 'package:foodpanda_users_app/widgets/text_field.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/address.dart';





class SaveAddressScreen extends StatelessWidget {
  final _name = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _flatnumber = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();
  final _complateAddress= TextEditingController();
  final _locationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<Placemark>? placemarks;

  Position? position;
  
  
  getUserLocationAddress() async
  {

    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position newposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
    );

    position = newposition;

    placemarks = await placemarkFromCoordinates(
        position!.latitude,
        position!.longitude
    );

    Placemark pMark = placemarks![0];

    String fullAddress = '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country} ';

    _locationController.text= fullAddress;

    _flatnumber.text ='${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}';

    _city.text = '${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}';

    _state.text = '${pMark.country}';
    _complateAddress.text =  fullAddress;







  }
  





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.cyan,
                  Colors.amber,
                ],
                begin:  FractionalOffset(0.0, 0.0),
                end:  FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
              )
          ),
        ),
        centerTitle: true,
        title: const Text(
          "iFood",
          style: TextStyle(fontSize: 45, fontFamily: "Signatra"),
        ),


      ),

      floatingActionButton: FloatingActionButton.extended(
        label: Text("Save now"),
        icon: Icon(Icons.check),
        onPressed: ()
        {
          //save Address Info
          //if the form is validated
          if(formKey.currentState!.validate())
          {
            final model = Address(
                name: _name.text.trim(),
                state: _state.text.trim(),
                fullAddress: _complateAddress.text.trim(),
                phoneNumber: _phoneNumber.text.trim(),
                flatNumber: _flatnumber.text.trim(),
                city: _city.text.trim(),
                lat:position!.latitude,
                lng: position!.longitude
            ).tojson();

            FirebaseFirestore.instance.collection("users")
                .doc(sharedPreferences!.getString("uid"))
                .collection("userAddress").doc(DateTime.now().millisecondsSinceEpoch.toString())
                .set(model).then((value)
            {
              Fluttertoast.showToast(msg: "New Address has been saved.");
              formKey.currentState!.reset();
            });
          }
          Navigator.pop(context);
        },
      ),

      body: SingleChildScrollView(
        child: Column(

          children:  [
            const SizedBox(height: 6,),
           const Align(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Save New Address",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),

            ListTile(
              leading: const Icon(
                Icons.person_pin_circle,
                color: Colors.black,
                size: 35,
              ),

              title: Container(
                width: 255,
                child: TextField(
                  style: const TextStyle(
                    color: Colors.black,
                  ),

                  controller: _locationController,
                  decoration: const InputDecoration(
                    hintText: "whats your address?",
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),

              ),

            ),


            SizedBox(height: 10,),

            ElevatedButton.icon(
              label: const Text(
                "get my location",
                style: TextStyle(
                  color: Colors.white,
                ),

              ),

              icon: const Icon(
                Icons.location_on, color: Colors.black,
              ),

              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),

              onPressed: ()
              {
                //getcurrentloaction
                getUserLocationAddress();

              },

            ),

            Form(
              key: formKey,
              child: Column(
                children: [
                  MyTextField(hint: 'name', controller: _name,),
                  MyTextField(hint: 'phone number', controller: _phoneNumber,),
                  MyTextField(hint: 'City', controller: _city,),
                  MyTextField(hint: 'State / Country', controller: _state,),
                  MyTextField(hint: 'Address Line', controller: _flatnumber,),
                  MyTextField(hint: 'Complate Address', controller: _complateAddress,),
                ],
              ),
            ),


          ],
        ),

      ),
    );

  }
}
