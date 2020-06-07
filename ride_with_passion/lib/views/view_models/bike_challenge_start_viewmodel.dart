import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_with_passion/function_utils.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/models/route.dart';
import 'package:ride_with_passion/router.dart';
import 'package:ride_with_passion/services/location_service.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:ride_with_passion/views/widgets/timer_countdown_widget.dart';
import 'package:rxdart/rxdart.dart';

class BikeChallengeStartViewModel extends ChangeNotifier {
  final _locationService = getIt<LocationService>();

  BitmapDescriptor _customLocationIcon;

  BehaviorSubject<bool> isOnStartLine = BehaviorSubject();
  BehaviorSubject<Position> _positionStream = BehaviorSubject();

  BehaviorSubject<Position> get positionStream => _positionStream;

  ChallengeRoute challengeRoute;
  PageController pageController;
  Position raceStartLocation;
  Position raceEndLocation;

  BitmapDescriptor get customLocationIcon => _customLocationIcon;

  BikeChallengeStartViewModel(ChallengeRoute challengeRoute) {
    this.challengeRoute = challengeRoute;
    _initGoogleMap();
    _updateGeoService();
  }

  LatLng raceLatLng() {
    return LatLng(raceStartLocation.latitude, raceStartLocation.longitude);
  }

  _initGoogleMap() async {
    /*_customLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/bike_pin.png');*/
    raceStartLocation = Position(
        latitude: challengeRoute.startCoordinates.lat,
        longitude: challengeRoute.startCoordinates.lon);
    raceEndLocation = Position(
        latitude: challengeRoute.endCoordinates.lat,
        longitude: challengeRoute.endCoordinates.lon);
    print('init race location ${raceStartLocation.latitude}');
  }

  _updateGeoService() async {
    _positionStream.value = await _locationService.getCurrentPosition();
    final initDistance = await _locationService.getDistance(
        raceStartLocation, positionStream.value);
    isOnStartLine.value = await FunctionUtils.isDoubleBelow(initDistance);

    _locationService.getUpdateLocation((newPosition) {
      _positionStream.add(newPosition);
      _locationService
          .getDistance(raceStartLocation, newPosition)
          .then((distance) async {
        print(
            'distance $distance race lat:${raceStartLocation.latitude} long:${raceStartLocation.longitude}');
        isOnStartLine.value = await FunctionUtils.isDoubleBelow(distance);
      });
    });
  }

  void onBikeChallengeStart() {
    Get.offNamed(BikeChallengesTimerRoute, arguments: challengeRoute);
    Get.dialog(
        CountDownTimer(
          secondsRemaining: 10,
          whenTimeExpires: () {
            Get.back();
          },
          challengeRouteName: challengeRoute.name,
          countDownTimerStyle: title60sp.copyWith(color: textColorSecondary),
        ),
        barrierDismissible: false);
  }

  @override
  void dispose() {
    isOnStartLine.close();
    _positionStream.close();
    super.dispose();
  }
}
