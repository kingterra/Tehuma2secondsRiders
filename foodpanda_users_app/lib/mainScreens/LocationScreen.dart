import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class LocationScreen extends StatefulWidget {

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  GoogleMapController? newGoogleMapController;

  final Completer<GoogleMapController> _controllerGoogleMap = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.4165, -3.70256),
    zoom: 14.4746,
  );

  Position? userCurrentPosition;
  var geoLocator = Geolocator();
  LocationPermission? _locationPermission;

  locateUserPosition() async
  {
    Position cPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    userCurrentPosition = cPosition;

    LatLng latLngPosition = LatLng(userCurrentPosition!.latitude, userCurrentPosition!.longitude);

    CameraPosition cameraPosition = CameraPosition(target: latLngPosition, zoom: 14);

    newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  checkIfLocationPermissionAllowed() async
  {
    _locationPermission = await Geolocator.requestPermission();

    if(_locationPermission == LocationPermission.denied)
      {
        _locationPermission = await Geolocator.requestPermission();
      }
  }

  @override
  void initState()
  {
    super.initState();

    checkIfLocationPermissionAllowed();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller)
            {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              locateUserPosition();
            }
        )
      ],
    );

  }

/*
    GoogleMapController ?_googleMapController;     //EN TEORIA NO LLEVA EL '?'
    Marker ?_origin;                      //EN TEORIA NO LLEVA EL '?'
    Marker ?_destination;               //EN TEORIA NO LLEVA EL '?'
    Directions ?_info;

    @override
    void dispose() {
      _googleMapController?.dispose();      //EN TEORIA NO LLEVA EL '?'
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Map'),
        /*actions: [
          if (_origin != null)
          TextButton(
            onPressed: () => _googleMapController?.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: _origin.position,
                  zoom: 16,
                  tilt: 50.0,
                ),
              ),
            ),
            style: TextButton.styleFrom(
              primary: Colors.lightGreen,
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
            child: const Text('Origin'),
          ),
          if (_destination != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _destination.position,
                    zoom: 16,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.redAccent,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('Destination'),
            ),
        ],*/
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) => _googleMapController = controller,
        //mapType: MapType.normal,
        markers: {
         /* if (_origin != null) _origin,
          if (_destination != null) _destination*/
        },
        onLongPress: _addMarker,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController?.animateCamera(
          CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      )
    );
  }

    void _addMarker(LatLng pos) async {
      if(_origin == null ||(_origin!=null && _destination!=null)){
        // Origin is not set OR Origin/Destination are both set
        // Set origin
        setState(() {
        _origin=Marker(
          markerId:const MarkerId('origin'),
          infoWindow:const InfoWindow(title: 'Origin'),
          icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
          position:pos,
        );// Marker
/*
        // Reset destination
        _destination = null;

        //Reset info
        _info = null;*/

      });
    } else {
      // Origin is already set
      // Set destination
      setState(() {
        _destination = Marker(
          markerId:  const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: pos,
        );
      });

      //Get directions
        /*final directions = await DirectionsRepository()
          .getDirections(origin: _origin.position, destination: pos);
        setState(() => _info = directions);*/
    }
}
*/
}