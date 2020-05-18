// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimerObject _$TimerObjectFromJson(Map json) {
  return TimerObject(
    startTime: json['startTime'] == null
        ? null
        : DateTime.parse(json['startTime'] as String),
    challengeRoute: json['challengeRoute'] == null
        ? null
        : ChallengeRoute.fromJson((json['challengeRoute'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
  );
}

Map<String, dynamic> _$TimerObjectToJson(TimerObject instance) =>
    <String, dynamic>{
      'startTime': instance.startTime?.toIso8601String(),
      'challengeRoute': instance.challengeRoute?.toJson(),
    };
