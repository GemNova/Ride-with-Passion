import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ride_with_passion/helper/constants.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:ride_with_passion/views/view_models/home_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:ride_with_passion/views/widgets/main_title_text_widget.dart';
import 'package:ride_with_passion/views/widgets/timer_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
      viewModel: HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(239, 236, 219, 1),
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
            child: MainTitleTextWidget(),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: model.onLogoutPressed,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TimerWidget(
                streamTimer: model.timerCounter,
                running: model.running,
              ),
              GestureDetector(
                child: _buildBikeChallenge(),
                onTap: model.onBikeChallengePressed,
              ),
              bigSpace,
              Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      child: _buildRennradRouten(),
                      onTap: () => model.onBikeChallengePressed(
                          routeType: RouteType.Race),
                    ),
                  ),
                  smallSpace,
                  Expanded(
                    child: GestureDetector(
                      child: _buildMountainBike(),
                      onTap: () => model.onBikeChallengePressed(
                          routeType: RouteType.MTB),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildBikeChallenge() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 300,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              "assets/images/bike_challenges.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        smallSpace,
        Text(
          'Bike Challenges',
          style: title18sp.merge(TextStyle(color: textColorSecondary)),
        ),
      ],
    );
  }

  _buildRennradRouten() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            "assets/images/renrad_route.png",
            fit: BoxFit.cover,
          ),
        ),
        smallSpace,
        Text('Rennrad Routen',
            style: title18sp.merge(TextStyle(color: textColorSecondary))),
      ],
    );
  }

  _buildMountainBike() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            "assets/images/mountain_route.png",
            fit: BoxFit.cover,
          ),
        ),
        smallSpace,
        Text(
          'Mountainbike Routen',
          style: title18sp.merge(TextStyle(color: textColorSecondary)),
          maxLines: 1,
        ),
      ],
    );
  }
}
