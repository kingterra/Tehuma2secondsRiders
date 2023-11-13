import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../global/global.dart';


class UserLocation {




  Future<bool> requestLocationPermission() async {
  final permission = await Geolocator.requestPermission();
  return permission == LocationPermission.always ||
  permission == LocationPermission.whileInUse;
  }

  Future<void> getCurrentLocation() async {
  final hasLocationPermission = await requestLocationPermission();
  if (!hasLocationPermission) {
  // Handle the case where the user denied location permissions
  print('User denied location permissions');
  return;
  }

  Position newPosition = await Geolocator.getCurrentPosition(
  desiredAccuracy: LocationAccuracy.high,
  );

  position = newPosition;

  placeMarks = await placemarkFromCoordinates(
  position!.latitude,
  position!.longitude,
  );

  Placemark pMark = placeMarks![0];

  completeAddress =
  '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';
  }
  }
