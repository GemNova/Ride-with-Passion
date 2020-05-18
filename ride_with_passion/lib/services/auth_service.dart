import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/logger.dart';
import 'package:ride_with_passion/models/user.dart';
import 'package:ride_with_passion/router.dart';
import 'package:ride_with_passion/services/firebase_service.dart';
import 'package:rxdart/subjects.dart';

enum AuthProblems { UserNotFound, PasswordNotValid, NetworkError }

class AuthService with ChangeNotifier {
  final _authInstance = FirebaseAuth.instance;
  final _firebaseService = getIt<FirebaseService>();
  BehaviorSubject<bool> isLoggedIn = BehaviorSubject();
  User user;
  final log = getLogger("AuthService");

  AuthService() {
    _authInstance.onAuthStateChanged.listen((firebaseUser) async {
      if (firebaseUser != null) {
        isLoggedIn.add(true);
        this.user = await _firebaseService.getUser(firebaseUser);
      } else
        isLoggedIn.add(false);
    });
  }

  void logout() {
    _authInstance.signOut();
    this.user = null;
    isLoggedIn.add(false);
    Get.offAllNamed(LoginRoute);
  }

  Future loginUser({@required String email, @required String password}) async {
    try {
      return await _authInstance.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      _printError(e);
      return Future.error(e.message);
    }
  }

  Future registerUser(
      {String email,
      String password,
      String firstName,
      String lastName,
      String bikeType}) async {
    try {
      AuthResult result = await _authInstance.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = User(
          id: result.user.uid,
          email: email,
          firstName: firstName,
          lastName: lastName,
          bikeType: bikeType);
      _firebaseService.saveUser(user);
      return user;
    } catch (e) {
      _printError(e);
      return Future.error(e.message);
    }
  }

  _printError(e) {
    AuthProblems errorType;
    if (Platform.isAndroid) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          errorType = AuthProblems.UserNotFound;
          break;
        case 'The password is invalid or the user does not have a password.':
          errorType = AuthProblems.PasswordNotValid;
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          errorType = AuthProblems.NetworkError;
          break;
        // ...
        default:
          print('Case ${e.message} is not jet implemented');
      }
    } else if (Platform.isIOS) {
      switch (e.code) {
        case 'Error 17011':
          errorType = AuthProblems.UserNotFound;
          break;
        case 'Error 17009':
          errorType = AuthProblems.PasswordNotValid;
          break;
        case 'Error 17020':
          errorType = AuthProblems.NetworkError;
          break;
        // ...
        default:
          print('Case ${e.message} is not jet implemented');
      }
    }
    print('The error is $errorType');
  }
}
