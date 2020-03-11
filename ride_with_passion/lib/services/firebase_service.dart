import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ride_with_passion/models/user.dart';

enum AuthProblems { UserNotFound, PasswordNotValid, NetworkError }

class FirebaseService {
  var _fireStoreInstance = Firestore.instance;

  saveUser(User user) {
    // user.authId = this.user.uid;
    // _fireStoreInstance
    //     .collection("users")
    //     .document(this.user.uid)
    //     .setData(user.toJson());
  }
}
