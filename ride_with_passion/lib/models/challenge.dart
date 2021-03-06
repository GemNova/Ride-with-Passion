import 'package:ride_with_passion/models/route.dart';

class Challenge {
  int userId;
  String trackId;
  String challengeName;
  Duration duration;
  List<Rank> rankList;
  Coordinates endCoordinates;

  Challenge({
    this.userId,
    this.duration,
    this.rankList,
    this.challengeName,
    this.trackId,
    this.endCoordinates,
  });
}
