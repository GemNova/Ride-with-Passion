// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChallengeRoute _$ChallengeRouteFromJson(Map json) {
  return ChallengeRoute(
    averageSlope: (json['averageSlope'] as num)?.toDouble(),
    startCoordinates: json['startCoordinates'] == null
        ? null
        : Coordinates.fromJson((json['startCoordinates'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    endCoordinates: json['endCoordinates'] == null
        ? null
        : Coordinates.fromJson((json['endCoordinates'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    description: json['description'] as String,
    difficulty: json['difficulty'] as String,
    durationMax: json['durationMax'] as int,
    durationMin: json['durationMin'] as int,
    heightProfile: json['heightProfile'] as String,
    images: (json['images'] as List)?.map((e) => e as String)?.toList(),
    length: (json['length'] as num)?.toDouble(),
    mapImage: json['mapImage'] as String,
    name: json['name'] as String,
    routeId: json['routeId'] as String,
    elevationGain: json['elevationGain'] as int,
    isDebug: json['isDebug'] as bool,
    routeType: json['routeType'] as String,
    sponsorImage: json['sponsorImage'] as String,
  )
    ..featured = json['featured'] as bool
    ..routeGpxFile = json['routeGpxFile'] as String
    ..rankList = (json['rankList'] as List)
        ?.map((e) => e == null
            ? null
            : Rank.fromJson((e as Map)?.map(
                (k, e) => MapEntry(k as String, e),
              )))
        ?.toList();
}

Map<String, dynamic> _$ChallengeRouteToJson(ChallengeRoute instance) =>
    <String, dynamic>{
      'routeId': instance.routeId,
      'name': instance.name,
      'images': instance.images,
      'sponsorImage': instance.sponsorImage,
      'mapImage': instance.mapImage,
      'description': instance.description,
      'heightProfile': instance.heightProfile,
      'difficulty': instance.difficulty,
      'length': instance.length,
      'durationMin': instance.durationMin,
      'featured': instance.featured,
      'durationMax': instance.durationMax,
      'averageSlope': instance.averageSlope,
      'elevationGain': instance.elevationGain,
      'startCoordinates': instance.startCoordinates?.toJson(),
      'endCoordinates': instance.endCoordinates?.toJson(),
      'routeGpxFile': instance.routeGpxFile,
      'routeType': instance.routeType,
      'isDebug': instance.isDebug,
      'rankList': instance.rankList?.map((e) => e?.toJson())?.toList(),
    };

Rank _$RankFromJson(Map json) {
  return Rank(
    userId: json['userId'] as String,
    bikeType: json['bikeType'] as String,
    gender: json['gender'] as String,
    lastName: json['lastName'] as String,
    userName: json['userName'] as String,
    trackedTime: json['trackedTime'] as int,
  );
}

Map<String, dynamic> _$RankToJson(Rank instance) => <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'bikeType': instance.bikeType,
      'trackedTime': instance.trackedTime,
    };

Coordinates _$CoordinatesFromJson(Map json) {
  return Coordinates(
    lat: (json['lat'] as num)?.toDouble(),
    lon: (json['lon'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
    };
