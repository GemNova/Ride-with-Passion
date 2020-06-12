import 'package:flutter/material.dart';
import 'package:ride_with_passion/models/route.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:ride_with_passion/views/view_models/bike_challenge_timer_viewmodel.dart';
import 'package:ride_with_passion/views/widgets/app_bar_blue_widget.dart';
import 'package:ride_with_passion/views/widgets/custom_button.dart';
import 'package:ride_with_passion/views/widgets/text_title_top_widget.dart';
import 'package:rxdart/rxdart.dart';

class BikeChallengeTimerScreen extends StatelessWidget {
  const BikeChallengeTimerScreen(this.challengeRoute, {Key key})
      : super(key: key);
  final ChallengeRoute challengeRoute;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BikeChallengeTimerViewModel>.withConsumer(
      viewModelBuilder: () => BikeChallengeTimerViewModel(this.challengeRoute),
      builder: (context, model, child) => Scaffold(
        appBar: AppBarBlueWidget(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(alignment: Alignment.topCenter, child: _title()),
              //_description(),
              Expanded(child: _timerCounter(model.timerCounter)),
              Align(
                alignment: Alignment.bottomCenter,
                child: StreamBuilder(
                  stream: model.running,
                  builder: (context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data) {
                        return Column(
                          children: <Widget>[
                            smallSpace,
                            _finishButton(model),
                            smallSpace,
                            _cancelTimerButton(model),
                          ],
                        );
                      } else {
                        return Column(
                          children: <Widget>[
                            smallSpace,
                            _startTimerButton(model),
                          ],
                        );
                      }
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        smallSpace,
        TextTitleTopWidget(),
        smallSpace,
        ChallengeNameTextWidget(challengeName: this.challengeRoute.name),
      ],
    );
  }

  Widget _timerCounter(BehaviorSubject<String> streamTimer) {
    return StreamBuilder(
      stream: streamTimer,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            return Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                color: Theme.of(context).canvasColor,
                child: Center(
                  child: Text(snapshot.data,
                      style: title60sp.copyWith(color: textColorSecondary)),
                ));
          }
        }
        return Container();
      },
    );
  }

  Widget _finishButton(BikeChallengeTimerViewModel model) {
    return CustomButton(
      text: 'Challenge erfolgreich beenden',
      padding: EdgeInsets.symmetric(vertical: 24),
      onPressed: model.finishChallenge,
      backGroundColor: textColorSecondary,
    );
  }

  Widget _cancelTimerButton(BikeChallengeTimerViewModel model) {
    return CustomButton(
      text: 'Challenge Abbrechen',
      padding: EdgeInsets.symmetric(vertical: 24),
      onPressed: model.stopTimer,
    );
  }

  Widget _startTimerButton(BikeChallengeTimerViewModel model) {
    return CustomButton(
      text: 'Start',
      padding: EdgeInsets.symmetric(vertical: 12),
      onPressed: model.startTimer,
    );
  }
}
