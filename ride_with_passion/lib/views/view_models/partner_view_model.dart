import 'package:flutter/material.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/models/partner.dart';
import 'package:ride_with_passion/services/firebase_service.dart';
import 'package:ride_with_passion/services/routes_repository.dart';

class PartnerViewModel extends ChangeNotifier {
  Future<List<Partner>> get partners => getIt<FirebaseService>().getPartner();
}
