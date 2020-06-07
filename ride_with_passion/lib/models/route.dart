import 'package:json_annotation/json_annotation.dart';

part 'route.g.dart';

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class ChallengeRoute {
  String routeId;
  String name;
  List<String> images;
  String sponsorImage;
  String mapImage;
  String description;
  String heightProfile;
  String difficulty;
  double length;
  int durationMin;
  bool featured;
  int durationMax;
  double averageSlope;
  int elevationGain;
  Coordinates startCoordinates;
  Coordinates endCoordinates;
  String routeGpxFile;
  String routeType;
  List<Rank> rankList;

  ChallengeRoute({
    this.averageSlope,
    this.startCoordinates,
    this.endCoordinates,
    this.description,
    this.difficulty,
    this.durationMax,
    this.durationMin,
    this.heightProfile,
    this.images,
    this.length,
    this.mapImage,
    this.name,
    this.routeId,
    this.elevationGain,
    this.routeType,
    this.sponsorImage,
  });

  factory ChallengeRoute.fromJson(Map<String, dynamic> json) =>
      _$ChallengeRouteFromJson(json);

  Map<String, dynamic> toJson() => _$ChallengeRouteToJson(this);
}

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class Rank {
  String userId;
  String userName;
  String lastName;
  String gender;
  String bikeType;
  int trackedTime;

  Rank({
    this.userId,
    this.bikeType,
    this.gender,
    this.lastName,
    this.userName,
    this.trackedTime,
  });

  factory Rank.fromJson(Map<String, dynamic> json) => _$RankFromJson(json);

  Map<String, dynamic> toJson() => _$RankToJson(this);
}

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class Coordinates {
  double lat;
  double lon;

  Coordinates({
    this.lat,
    this.lon,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
}

extension CompareExtension on ChallengeRoute {
  int compareTo(other) {
    if (this.featured == null || other == null) {
      return null;
    }

    if (this.featured) {
      return 1;
    }

    if (!this.featured) {
      return -1;
    }

    return null;
  }
}
