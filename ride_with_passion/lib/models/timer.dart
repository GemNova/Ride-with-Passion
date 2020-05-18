import 'package:json_annotation/json_annotation.dart';
import 'package:ride_with_passion/models/route.dart';

part 'timer.g.dart';

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class TimerObject {
  DateTime startTime;
  ChallengeRoute challengeRoute;

  TimerObject({this.startTime, this.challengeRoute});

  factory TimerObject.fromJson(Map<String, dynamic> json) =>
      _$TimerObjectFromJson(json);
  Map<String, dynamic> toJson() => _$TimerObjectToJson(this);
}
