import 'package:flutter/material.dart';
import 'package:ride_with_passion/styles.dart';

class TextTitleTopWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Bike Challenge',
      style: title32sp.copyWith(color: accentColor),
    );
  }
}

class ChallengeNameTextWidget extends StatelessWidget {
  final String challengeName;

  const ChallengeNameTextWidget({Key key, this.challengeName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      challengeName,
      style: title24sp.copyWith(color: textColorSecondary),
      textAlign: TextAlign.center,
    );
  }
}
