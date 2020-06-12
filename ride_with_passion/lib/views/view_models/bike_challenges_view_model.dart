import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/models/route.dart';
import 'package:ride_with_passion/router.dart';
import 'package:ride_with_passion/services/firebase_service.dart';
import 'package:ride_with_passion/services/timer_service.dart';
import 'package:rxdart/rxdart.dart';

class BikeChallengesViewModel extends ChangeNotifier {
  final _timerService = getIt<TimerService>();
  final _firebaseService = getIt<FirebaseService>();

  int chosenIndex = 0;
  bool isDownloading = false;

  String choiceValue = 'Bike';

  String genderChosen;

  List<Rank> rankList = [];

  List<Rank> filteredRankList = [];

  List<Rank> filteredRankListByGender = [];

  BehaviorSubject<String> get timerCounter => _timerService.timerCounter;

  BehaviorSubject<bool> get running => _timerService.running;

  ChallengeRoute get challengeRounte => _timerService.challengeRoute;

  BikeChallengesViewModel(ChallengeRoute challengeRoute) {
    this.challengeRoute = challengeRoute;
    ranks();
    _currentPageIndex = 0;
  }

  ChallengeRoute challengeRoute;
  PageController pageController;
  bool _isMapView = false;
  int _currentPageIndex;

  bool get isMapView => _isMapView;

  int get currentPageIndex => _currentPageIndex;

  ranks() async {
    rankList = await _firebaseService.getRanks(challengeRoute.routeId);
    filteredRankList = rankList.where((element) {
      return element.bikeType?.toLowerCase() == this.choiceValue.toLowerCase();
    }).toList();
    if (genderChosen != null) {
      filteredRankList = filteredRankList.where((element) {
        return element.gender == this.genderChosen;
      }).toList();
    } else {
      filteredRankList = filteredRankList.where((element) {
        return element.gender != null;
      }).toList();
    }
    filteredRankList.sort((x, y) => x.trackedTime.compareTo(y.trackedTime));

    notifyListeners();
  }

  void handleTabSelection(int index) {
    switch (index) {
      case 0:
        genderChosen = null;
        filteredRankList = rankList
            .where((element) =>
                element.bikeType?.toLowerCase() ==
                    this.choiceValue.toLowerCase() &&
                element.gender != null)
            .toList();
        filteredRankList.sort((x, y) => x.trackedTime.compareTo(y.trackedTime));
        break;
      case 1:
        genderChosen = 'Männlich';
        filteredRankList = rankList
            .where((element) =>
                element.bikeType?.toLowerCase() ==
                    this.choiceValue.toLowerCase() &&
                element.gender == this.genderChosen)
            .toList();
        filteredRankList.sort((x, y) => x.trackedTime.compareTo(y.trackedTime));
        break;
      case 2:
        genderChosen = 'Weiblich';
        filteredRankList = rankList
            .where((element) =>
                element.bikeType?.toLowerCase() ==
                    this.choiceValue.toLowerCase() &&
                element.gender == this.genderChosen)
            .toList();
        filteredRankList.sort((x, y) => x.trackedTime.compareTo(y.trackedTime));

        break;
    }
    notifyListeners();
  }

  onChipSelected(String value) {
    choiceValue = value;
    filteredRankList = rankList
        .where((element) =>
            element.bikeType?.toLowerCase() == this.choiceValue.toLowerCase())
        .toList();
    if (genderChosen != null) {
      filteredRankList = filteredRankList.where((element) {
        return element.gender == this.genderChosen;
      }).toList();
    } else {
      filteredRankList = filteredRankList.where((element) {
        return element.gender != null;
      }).toList();
    }
    filteredRankList.sort((x, y) => x.trackedTime.compareTo(y.trackedTime));
    notifyListeners();
  }

  onSwipe() {
    _currentPageIndex = pageController.page.toInt();
    notifyListeners();
  }

  carouselSlide(int index) {
    this.chosenIndex = index;
    notifyListeners();
  }

  Future<bool> isOngoingChallengeSame() async {
    return _timerService.isAllowedToTimerScreen(this.challengeRoute);
  }

  void onBikeChallengeStartPressed(ChallengeRoute challengeRoute) async {
    bool isSettingTimerEmpty = await _timerService.isSettingTimerEmpty();
    if (!isSettingTimerEmpty || _timerService.running.value) {
      Get.toNamed(BikeChallengesTimerRoute, arguments: challengeRoute);
    } else {
      Get.toNamed(BikeChallengesStartRoute, arguments: challengeRoute);
    }
  }

  onPrevImagePressed() {
    _currentPageIndex = _currentPageIndex == 0 ? 0 : _currentPageIndex - 1;
    _slideToAnotherImage();
  }

  onNextImagePressed() {
    _currentPageIndex = _currentPageIndex == challengeRoute.images.length - 1
        ? challengeRoute.images.length - 1
        : _currentPageIndex + 1;
    _slideToAnotherImage();
  }

  _slideToAnotherImage() {
    pageController.animateToPage(_currentPageIndex,
        duration: Duration(milliseconds: 500), curve: Curves.linear);
    notifyListeners();
  }

  void toggleMapViewPage(bool value) {
    _isMapView = value;
    notifyListeners();
  }

  onDownloadGpxFilePressed() async {
    isDownloading = true;
    notifyListeners();
    File file = await getIt<FirebaseService>()
        .downloadFile(challengeRoute.routeGpxFile);

    isDownloading = false;
    notifyListeners();
    OpenFile.open(file.path);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
