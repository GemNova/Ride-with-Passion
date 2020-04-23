import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  final geolocator = Geolocator();

  final _locationOptions =
      LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

  void getUpdateLocation(ValueChanged<Position> onPositionChange) {
    try {
      geolocator
          .getPositionStream(_locationOptions)
          .listen((Position position) {
        if (position != null) {
          onPositionChange(position);
        }
      });
    } catch (error) {
      print(error);
    }
  }

  void checkPermission() async {
    Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
    GeolocationStatus geolocationStatus =
        await geolocator.checkGeolocationPermissionStatus();
    print(geolocationStatus);
  }

  Future<double> getDistance(Position positionOld, Position positionNew) async {
    final distanceInMeters = await Geolocator().distanceBetween(
        positionOld.latitude,
        positionOld.longitude,
        positionNew.latitude,
        positionNew.longitude);
    return distanceInMeters;
  }
}
