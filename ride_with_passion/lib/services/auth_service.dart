import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  var _fireStoreInstance = Firestore.instance;
  final _authInstance = FirebaseAuth.instance;
  final _firebaseService = getIt<FirebaseService>();
  BehaviorSubject<bool> isLoggedIn = BehaviorSubject();
  BehaviorSubject<User> userStream = BehaviorSubject();

  StreamSubscription subscriptionLogin;
  StreamSubscription subscriptionUserDetail;

  User user;
  final log = getLogger("AuthService");

  AuthService() {
    subscriptionLogin =
        _authInstance.onAuthStateChanged.listen((firebaseUser) async {
      if (firebaseUser != null) {
        isLoggedIn.add(true);
        this.user = await _firebaseService.getUser(firebaseUser);
        userStream.add(this.user);
        //todo need to look this code. how to move in firebase service.
        subscriptionUserDetail = _fireStoreInstance
            .collection("users")
            .document(this.user.id)
            .snapshots()
            .listen((DocumentSnapshot documentSnapshot) {
          User user;
          user = User.fromJson(documentSnapshot.data);
          userStream.add(user);
        });
      } else
        isLoggedIn.add(false);
    });
  }

  void logout() {
    _authInstance.signOut();
    this.user = null;
    isLoggedIn.add(false);
    subscriptionUserDetail.cancel();
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

  Future editUser({
    String id,
    String firstName,
    String lastName,
    String bikeType,
    String gender,
    File image,
    String imageUrl,
    DateTime birthDate,
    String street,
    String houseNumber,
    String city,
    String postCode,
    String country,
  }) async {
    try {
      if (image != null && imageUrl == null) {
        imageUrl = await saveImage(image);
      }

      final user = User(
        id: id,
        firstName: firstName,
        lastName: lastName,
        bikeType: bikeType,
        gender: gender,
        imageUrl: imageUrl,
        birthDate: birthDate,
        street: street,
        houseNumber: houseNumber,
        city: city,
        postCode: postCode,
        country: country,
      );
      await _firebaseService.editUser(user);
    } catch (e) {
      _printError(e);
      return Future.error(e.message);
    }
  }

  Future registerUser({
    String email,
    String password,
    String firstName,
    String lastName,
    String bikeType,
    String gender,
    File image,
    DateTime birthDate,
    String street,
    String houseNumber,
    String city,
    String postCode,
    String country,
  }) async {
    try {
      //this is to wait the data already pushed to firebase before trigger listener
      //to avoid not found user id
      subscriptionLogin.pause();

      AuthResult result = await _authInstance.createUserWithEmailAndPassword(
          email: email, password: password);
      String imageUrl;
      if (image != null) {
        imageUrl = await saveImage(image);
      }
      final user = User(
        id: result.user.uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
        bikeType: bikeType,
        gender: gender,
        imageUrl: imageUrl,
        birthDate: birthDate,
        street: street,
        houseNumber: houseNumber,
        city: city,
        postCode: postCode,
        country: country,
      );
      await _firebaseService.saveUser(user);
      isLoggedIn.add(true);
      subscriptionLogin.resume();
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

  Future<String> saveImage(File file) async {
    StorageReference ref = FirebaseStorage()
        .ref()
        .child("user_profile/${DateTime.now().millisecondsSinceEpoch}.jpg");
    ref.getPath().then((path) => print("uploaded to $path"));
    await ref.putFile(file).onComplete;
    return await ref.getDownloadURL();
  }
}
