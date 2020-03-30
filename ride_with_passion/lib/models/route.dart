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
  int durationMax;
  double averageSlope;
  int elevationGain;
  Coordinates startCoordinates;
  Coordinates endCoordinates;
  String routeGpxFile;
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
    this.sponsorImage,
  });

  factory ChallengeRoute.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);
  Map<String, dynamic> toJson() => _$RouteToJson(this);
}

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class Rank {
  String userName;
  int trackedTime;

  Rank({
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
