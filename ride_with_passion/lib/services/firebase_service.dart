import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ride_with_passion/logger.dart';
import 'package:ride_with_passion/models/partner.dart';
import 'package:ride_with_passion/models/route.dart';
import 'package:ride_with_passion/models/user.dart';
import 'package:http/http.dart' as http;

enum AuthProblems { UserNotFound, PasswordNotValid, NetworkError }

class FirebaseService {
  var _fireStoreInstance = Firestore.instance;
  final logger = getLogger("FirebaseService");
  double minimumDistance = 0;

  Stream<List<ChallengeRoute>> getRoutes(bool isDebugUser) async* {
    await for (QuerySnapshot data
        in _fireStoreInstance.collection("routes").snapshots()) {
      var list =
          data.documents.map((d) => ChallengeRoute.fromJson(d.data)).toList();
      if (!isDebugUser) {
        list = list.where((element) => element.isDebug != true).toList();
      }
      //put featured route on top
      list.sort((a, b) {
        return b.compareTo(a);
      });
      yield list;
    }
  }

  Stream<User> userDetail(String userId) async* {
    _fireStoreInstance
        .collection("users")
        .document(userId)
        .snapshots()
        .listen((DocumentSnapshot documentSnapshot) async* {
      User user;
      user = User.fromJson(documentSnapshot.data);
      yield user;
    });
  }

  Future<List<Rank>> getRanks(String routeId, [User user]) async {
    QuerySnapshot querySnapshot = await _fireStoreInstance
        .collection('routes')
        .document(routeId)
        .collection('ranks')
        .where("bikeType", isEqualTo: user?.bikeType)
        .where("gender", isEqualTo: user?.gender)
        .getDocuments();
    final list =
        querySnapshot.documents.map((e) => Rank.fromJson(e.data)).toList();
    return list;
  }

  Future<List<Rank>> getRanksForUser(String userId) async {
    final ranks = [];
    QuerySnapshot querySnapshot =
        await _fireStoreInstance.collection('routes').getDocuments();

    for (var snapshot in querySnapshot.documents) {
      final documents = await snapshot.reference
          .collection('ranks')
          .where("userId", isEqualTo: userId)
          .getDocuments();

      logger.i(documents);
      final list =
          documents.documents.map((e) => Rank.fromJson(e.data)).toList();
      ranks.addAll(list);
    }

    logger.i(querySnapshot.documents);
    final list =
        querySnapshot.documents.map((e) => Rank.fromJson(e.data)).toList();
    return list;
  }

  copyRoute(ChallengeRoute route) {
    _fireStoreInstance.collection("routes").document().setData(route.toJson());
  }

  saveUser(User user) async {
    _fireStoreInstance
        .collection("users")
        .document(user.id)
        .setData(user.toJson());
  }

  editUser(User user) async {
    _fireStoreInstance
        .collection("users")
        .document(user.id)
        .updateData(user.toJson());
  }

  Future<User> getUser(FirebaseUser user) async {
    final doc =
        await _fireStoreInstance.collection("users").document(user.uid).get();
    return User.fromJson(doc.data);
  }

  Future<List<Partner>> getPartner() async {
    final documents =
        await _fireStoreInstance.collection("partner").getDocuments();
    List<Partner> partners = [];
    documents.documents.forEach((element) {
      final partner = Partner.fromJson(element.data);
      logger.i(partner);
      partners.add(partner);
      logger.i(partners.length);
    });
    return partners;
  }

  Future<double> getMinimumMeter() async {
    if (minimumDistance != 0) {
      return minimumDistance;
    }
    final doc = await _fireStoreInstance
        .collection('config')
        .document('mobileApp')
        .get();
    logger.i('gps start radius ${doc.data['gpsStartRadius'].toString()}');
    minimumDistance = doc.data['gpsStartRadius'].toDouble();
    return minimumDistance;
  }

  Future<File> downloadFile(String url) async {
    final http.Response downloadData = await http.get(url);
    final File tempFile = await _getFile();
    if (tempFile.existsSync()) {
      await tempFile.delete();
    }
    await tempFile.create();
    var file = await tempFile.writeAsBytes(downloadData.bodyBytes);
    logger.i('file succesfully written to: ${tempFile.path}');
    return file;
  }

  Future<File> _getFile() async {
    var _path = await _findLocalPath();
    final File tempFile =
        File('$_path/${DateTime.now().millisecondsSinceEpoch.toString()}');
    return tempFile;
  }

  Future<String> _findLocalPath() async {
    var directory = Platform.isAndroid
        ? await getApplicationDocumentsDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<int> sendRank(Rank rank, String routeId, User user) async {
    logger.i('send rank');
    final ranks = await getRanks(routeId, user);

    //find if the current user is have value in firebase
    final currentRank =
        ranks.firstWhere((element) => element.userId == rank.userId);

    ranks.add(rank);
    ranks.sort((x, y) => x.trackedTime.compareTo(y.trackedTime));
    final index = ranks.indexOf(rank);
    if (currentRank != null) {
      if (currentRank.trackedTime > rank.trackedTime) {
        await _fireStoreInstance
            .collection('routes')
            .document(routeId)
            .collection('ranks')
            .document(rank.userId)
            .setData(rank.toJson(), merge: true);
        logger
            .i('rank updated${rank.bikeType} ${rank.userName} ${rank.userId}');
      } else {
        logger.i(
            'rank not updated${rank.bikeType} ${rank.userName} ${rank.userId}');
      }
    } else {
      ranks.add(rank);
      await _fireStoreInstance
          .collection('routes')
          .document(routeId)
          .collection('ranks')
          .document(rank.userId)
          .setData(rank.toJson(), merge: true);
      logger.i('new rank ${rank.bikeType} ${rank.userName} ${rank.userId}');

      /// 1 is added to index because list is strted from 0th index
    }
    return index + 1;
  }
}
