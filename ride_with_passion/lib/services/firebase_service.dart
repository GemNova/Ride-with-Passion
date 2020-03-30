import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ride_with_passion/logger.dart';
import 'package:ride_with_passion/models/route.dart';
import 'package:ride_with_passion/models/user.dart';

enum AuthProblems { UserNotFound, PasswordNotValid, NetworkError }

class FirebaseService {
  var _fireStoreInstance = Firestore.instance;
  final logger = getLogger("FirebaseService");

  Stream<List<ChallengeRoute>> getRoutes() async* {
    await for (QuerySnapshot data
        in _fireStoreInstance.collection("routes").snapshots()) {
      final list = data.documents.map((d) => ChallengeRoute.fromJson(d.data)).toList();
      yield list;
    }
  }

  saveUser(User user) async {
    _fireStoreInstance
        .collection("users")
        .document(user.id)
        .setData(user.toJson());
  }

  Future<User> getUser(FirebaseUser user) async {
    final doc =
        await _fireStoreInstance.collection("users").document(user.uid).get();
    return User.fromJson(doc.data);
  }
}
