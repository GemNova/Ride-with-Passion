import 'package:flutter/material.dart';
import 'package:ride_with_passion/models/route.dart';
import 'package:ride_with_passion/styles.dart';

class TrackNameTypeWidget extends StatelessWidget {
  const TrackNameTypeWidget(
    this.route, {
    Key key,
  }) : super(key: key);
  final ChallengeRoute route;

  @override
  Widget build(BuildContext context) {
    final color = route.routeType == "race" ? textColorSecondary : accentColor;
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: color,
                width: 2.0,
              ),
            ),
            child: Text(
              route.difficulty.toUpperCase(),
              style: small14sp.copyWith(color: color),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Divider(
                  thickness: 2,
                  color: color,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(40)),
            child: Text(
              route.routeType.toUpperCase(),
              style: small14sp,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
