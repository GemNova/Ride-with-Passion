import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/models/challenge.dart';
import 'package:ride_with_passion/services/firebase_service.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:ride_with_passion/views/view_models/bike_challenge_end_viewmodel.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:ride_with_passion/views/widgets/app_bar_blue_widget.dart';
import 'package:ride_with_passion/views/widgets/custom_button.dart';
import 'package:ride_with_passion/views/widgets/text_title_top_widget.dart';

class BikeChallengeEndScreen extends StatelessWidget {
  const BikeChallengeEndScreen({Key key, this.route}) : super(key: key);
  final Challenge route;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BikeChallengeEndViewModel>.withConsumer(
      viewModelBuilder: () => BikeChallengeEndViewModel(),
      onModelReady: (model) {
        model.initUserRank(route);
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBarBlueWidget(
          hideBackButton: true,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              _title(),
              _description(),
              bigSpace,
              Text(
                "Deine Rundenzeit: ${getTIme()}",
                textAlign: TextAlign.center,
                style: title24sp.copyWith(fontWeight: FontWeight.w400),
              ),
              smallSpace,
              model.isLoading
                  ? Text(
                      "Berechne Rang...",
                      textAlign: TextAlign.center,
                      style: title24sp,
                    )
                  : Text(
                      "Rang: #${model.rankNumber}",
                      textAlign: TextAlign.center,
                      style: title24sp,
                    ),
              bigSpace,
              _completeButton(model),
              bigSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Column(
      children: <Widget>[
        bigSpace,
        TextTitleTopWidget(),
        smallSpace,
        ChallengeNameTextWidget(challengeName: route.challengeName),
        mediumSpace,
      ],
    );
  }

  Widget _description() {
    return Column(
      children: <Widget>[
        Image.asset(
          "assets/images/flag_finished.png",
          height: 240,
        ),
        Text(
          "Geschafft!!",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 28, color: Colors.black),
        )
      ],
    );
  }

  Widget _completeButton(BikeChallengeEndViewModel viewModel) {
    return Container(
      width: 300,
      child: CustomButton(
        text: 'CHALLENGE BEENDEN',
        padding: EdgeInsets.symmetric(vertical: 20),
        onPressed: viewModel.onBikeChallengeComplete,
      ),
    );
  }

  String getTIme() {
    final String time = route.duration.toString().substring(0, 7);
    return time;
  }
}
