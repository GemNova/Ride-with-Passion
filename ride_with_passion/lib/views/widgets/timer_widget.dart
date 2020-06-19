import 'package:flutter/material.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/models/route.dart';
import 'package:ride_with_passion/services/timer_service.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:rxdart/rxdart.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({this.streamTimer, this.running, Key key})
      : super(key: key);
  final BehaviorSubject<String> streamTimer;
  final BehaviorSubject<bool> running;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: running,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data) {
            return StreamBuilder(
              stream: streamTimer,
              builder: (context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != '00:00:00') {
                    ChallengeRoute challengeRoute =
                        getIt<TimerService>().challengeRoute;
                    return challengeRoute == null
                        ? Container()
                        : Container(
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(
                                    child: Text(
                                      'Challenge läuft! ${challengeRoute.name} ${snapshot.data}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        letterSpacing: -0.5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                  }
                }
                return Container();
              },
            );
          }
        }
        return Container();
      },
    );
  }
}
