import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ride_with_passion/helper/constants.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/models/route.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:ride_with_passion/views/screens/onboarding_screen.dart';
import 'package:ride_with_passion/views/view_models/home_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:ride_with_passion/views/widgets/custom_button.dart';
import 'package:ride_with_passion/views/widgets/main_title_text_widget.dart';
import 'package:ride_with_passion/views/widgets/timer_widget.dart';

import 'bike_challenge_timer_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
      disposeViewModel: false,
      viewModelBuilder: () => getIt<HomeViewModel>(),
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
              icon: Icon(
                Icons.person,
                color: accentColor,
              ),
              onPressed: model.onProfilePressed,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 32),
          child: ListView(
            children: <Widget>[
              TimerWidget(
                streamTimer: model.timerCounter,
                running: model.running,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                    child: Text(
                  "Hallo ${model?.user?.firstName ?? ""}!",
                  style: TextStyle(
                    fontSize: 26,
                    color: blackHeadingColor,
                    fontWeight: FontWeight.w600,
                  ),
                )),
              ),
              smallSpace,
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
              bigSpace,
              Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      child: _buildMoreInfo(),
                      onTap: model.onMoreInfoPressed,
                    ),
                  ),
                  smallSpace,
                  Expanded(
                    child: GestureDetector(
                      child: _buildPartner(),
                      onTap: model.onPartnerPressed,
                    ),
                  ),
                ],
              ),
              if (model?.user?.debugUser ?? false) _buildDebugRoute()
            ],
          ),
        ),
      ),
    );
  }

  _buildMoreInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
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
          'Mehr Infos',
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
            "assets/images/mountain_route.png",
            fit: BoxFit.cover,
          ),
        ),
        smallSpace,
        Text('RR Routen',
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
            "assets/images/mtb.png",
            fit: BoxFit.cover,
          ),
        ),
        smallSpace,
        Text(
          'MTB Routen',
          style: title18sp.merge(TextStyle(color: textColorSecondary)),
          maxLines: 1,
        ),
      ],
    );
  }

  _buildPartner() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            "assets/images/partner.png",
            fit: BoxFit.cover,
          ),
        ),
        smallSpace,
        Text(
          'Partner',
          style: title18sp.merge(TextStyle(color: textColorSecondary)),
          maxLines: 1,
        ),
      ],
    );
  }

  _buildDebugRoute() {
    return CustomButton(
      text: "Debug Route",
      onPressed: () {
        Get.to(BikeChallengeTimerScreen(
          ChallengeRoute(
            routeId: 'q07Cqq77JgqGSC7gvI5R',
            name: 'Tour zur Lanser Alm',
            startCoordinates: Coordinates(
              lat: 47.2322,
              lon: 11.4311,
            ),
            endCoordinates: Coordinates(
              lat: 48.2322,
              lon: 12.4311,
            ),
          ),
        ));
      },
    );
  }
}
