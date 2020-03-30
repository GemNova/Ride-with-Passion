import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/router.dart';
import 'package:ride_with_passion/services/location_service.dart';
import 'package:rxdart/rxdart.dart';

class BikeChallengesViewModel extends ChangeNotifier {
  BikeChallengesViewModel() {
    isOnStartLine.value = false;
    initGeoServcie();
    pageController = PageController();
  }
  PageController pageController;
  final locationService = getIt<LocationService>();
  double distanceFromStart = double.infinity;
  double distanceFromEnd = double.infinity;
  Position raceStartLocation;
  Position raceEndLocation;
  // bool isOnStartLine = false;
  bool isOnEndLine = false;
  BehaviorSubject<bool> isOnStartLine = BehaviorSubject()..add(false);
  BehaviorSubject<bool> isMapViewOpen = BehaviorSubject()..add(false);

  void onBikeChallengePressed() {}

  void onBikeChallengeStart() {}

  void onBikeChallengeStartPressed() {
    Get.toNamed(BikeChallengesStartRoute);
  }

  set setStartLocation(Position startPosition) {
    raceStartLocation = startPosition;
  }

  set setEndLocation(Position startPosition) {
    raceStartLocation = startPosition;
  }

  void initGeoServcie() {
    locationService.getUpdateLocation((newPosition) {
      locationService
          .getDistance(raceEndLocation, newPosition)
          .then((distance) {
        print(distance);
        if (distance < 50) {
          isOnStartLine.value = true;
        } else {
          isOnStartLine.value = false;
        }
      });
      locationService
          .getDistance(raceEndLocation, newPosition)
          .then((distance) {
        print(distance);
        if (distance < 50) {
          isOnEndLine = true;
        } else {
          isOnEndLine = false;
        }
      });
    });
  }

  void onCrouselIconPressed(int index){
    pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.linear);
  }

  void toggleMapViewPage(bool value){
    isMapViewOpen.add(value);
  }
}
