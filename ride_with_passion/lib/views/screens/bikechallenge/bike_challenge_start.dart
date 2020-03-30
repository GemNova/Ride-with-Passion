import 'package:flutter/material.dart';
import 'package:ride_with_passion/helper/constants.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:ride_with_passion/views/view_models/bike_challenges_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:ride_with_passion/views/widgets/custom_button.dart';

class BikeChallangesStartScreen extends StatelessWidget {
  const BikeChallangesStartScreen({Key key}) : super(key: key);
  Widget _title() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 16,
        ),
        Text('Bike Challenge', style: title24sp),
        Text(
          'Von Kals zum Lucknerhaus',
          style: title24sp.copyWith(color: accentColor),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _description() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 16,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
              text: 'Klicke auf ',
              style: medium18sp.copyWith(color: blackColor),
            ),
            TextSpan(
              text: 'START ',
              style: title18sp,
            ),
            TextSpan(
              text: challengeStartDescription1,
              style: medium18sp.copyWith(color: blackColor),
            ),
          ]),
        ),
        SizedBox(height: 30),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
              text: challengeStartDescription2,
              style: medium18sp.copyWith(color: blackColor),
            ),
          ]),
        ),
        SizedBox(height: 16),
        Text(
          'Na dann- von Kals zum Luckenerhaus',
          style: title18sp,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _startButton(BikeChallengesViewModel model) {
    return StreamBuilder(
      stream: model.isOnStartLine,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        String text = 'Du bist nicht in der Nähe der Startlinie';
        if (snapshot.hasData) {
          if (snapshot.data) {
            text = 'START';
          } else {
            text = 'Du bist nicht in der Nähe der Startlinie';
          }
        } else {
          text = 'Du bist nicht in der Nähe der Startlinie';
        }
        return CustomButton(
          text: text,
          padding: EdgeInsets.symmetric(vertical: 12),
          onPressed: snapshot.hasData && snapshot.data
              ? model.onBikeChallengeStart
              : () {},
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BikeChallengesViewModel>.withConsumer(
      viewModel: BikeChallengesViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Image.asset(
              "assets/ic_appbar.png",
              height: 60,
            ),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _title(),
              _description(),
              Spacer(),
              _startButton(model),
            ],
          ),
        ),
      ),
    );
  }
}
