import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_with_passion/models/route.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:ride_with_passion/views/view_models/bike_challenge_start_viewmodel.dart';
import 'package:ride_with_passion/views/widgets/app_bar_blue_widget.dart';
import 'package:ride_with_passion/views/widgets/custom_button.dart';
import 'package:ride_with_passion/views/widgets/custom_loading_indicator.dart';
import 'package:ride_with_passion/views/widgets/sponsor_card_widget.dart';
import 'package:ride_with_passion/views/widgets/text_title_top_widget.dart';

class BikeChallengeStartScreen extends StatelessWidget {
  const BikeChallengeStartScreen(this.challengeRoute, {Key key})
      : super(key: key);
  final ChallengeRoute challengeRoute;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BikeChallengeStartViewModel>.withConsumer(
      viewModelBuilder: () => BikeChallengeStartViewModel(this.challengeRoute),
      builder: (context, model, child) => Scaffold(
        appBar: AppBarBlueWidget(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(child: _topWidgets(model)),
              _startButton(model),
              smallSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _topWidgets(BikeChallengeStartViewModel model) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          bigSpace,
          TextTitleTopWidget(),
          ChallengeNameTextWidget(challengeName: this.challengeRoute.name),
          mediumSpace,
          _description(),
          smallSpace,
          _googleMap(model),
          mediumSpace,
          SponsorCardWidget(route: this.challengeRoute),
          mediumSpace,
        ],
      ),
    );
  }

  Widget _googleMap(BikeChallengeStartViewModel model) {
    return model.raceStartLocation == null
        ? Container()
        : Container(
            height: 400,
            child: GoogleMap(
              gestureRecognizers: Set()
                ..add(
                    Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                ..add(Factory<ScaleGestureRecognizer>(
                    () => ScaleGestureRecognizer()))
                ..add(
                    Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
                ..add(Factory<VerticalDragGestureRecognizer>(
                    () => VerticalDragGestureRecognizer())),
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: model.raceLatLng(),
                zoom: 18.0,
              ),
              markers: Set.from([
                Marker(
                  markerId: MarkerId(
                      "${model.challengeRoute.startCoordinates.lat}, ${model.challengeRoute.startCoordinates.lon}"),
                  position: model.raceLatLng(),
                  icon: BitmapDescriptor.defaultMarker,
                ),
                //todo use this if want to use custom marker
                /*Marker(
            markerId: MarkerId("current_location"),
            position: LatLng(snapshot.data.latitude,snapshot.data.longitude),
            icon: model.customLocationIcon,
          ),*/
              ]),
              circles: Set.from([
                Circle(
                  circleId: CircleId(
                    "${model.challengeRoute.startCoordinates.lat}, ${model.challengeRoute.startCoordinates.lon}",
                  ),
                  center: model.raceLatLng(),
                  radius: model.gpsRadius,
                  fillColor: Color.fromRGBO(173, 216, 230, 0.5),
                  strokeColor: Color.fromRGBO(173, 216, 230, 0.5),
                  strokeWidth: 2,
                )
              ]),
            ),
          );
  }

  Widget _startButton(BikeChallengeStartViewModel model) {
    return StreamBuilder(
      stream: model.isOnStartLine,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        String text = 'Du bist nicht in der Nähe der Startlinie';
        if (snapshot.hasData) {
          if (snapshot.data) {
            return Container(
              width: 250,
              height: 60,
              child: CustomButton(
                text: 'START',
                padding: EdgeInsets.symmetric(vertical: 12),
                backGroundColor: snapshot.hasData && snapshot.data
                    ? accentColor
                    : disabledColor,
                onPressed: snapshot.hasData && snapshot.data
                    ? model.onBikeChallengeStart
                    : null,
              ),
            );
          } else {
            text = 'Du bist nicht in der Nähe der Startlinie';
            return Container(
              height: 60,
              child: CustomButton(
                text: text,
                padding: EdgeInsets.symmetric(vertical: 12),
                backGroundColor: snapshot.hasData && snapshot.data
                    ? accentColor
                    : disabledColor,
                onPressed: snapshot.hasData && snapshot.data
                    ? model.onBikeChallengeStart
                    : null,
              ),
            );
          }
        } else {
          text = 'Suche Standort...';
        }
        return CustomButton(
          text: text,
          padding: EdgeInsets.symmetric(vertical: 12),
          backGroundColor:
              snapshot.hasData && snapshot.data ? accentColor : disabledColor,
          onPressed: snapshot.hasData && snapshot.data
              ? model.onBikeChallengeStart
              : null,
        );
      },
    );
  }
}

Widget _description() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        height: 16,
      ),
      RichText(
        textAlign: TextAlign.left,
        text: TextSpan(children: [
          TextSpan(
            text: 'Klicke auf ',
            style: medium18sp.copyWith(color: blackColor),
          ),
          TextSpan(
            text: 'START ',
            style: title18sp.copyWith(color: accentColor),
          ),
          TextSpan(
            text: ", sobald du dich in der Nähe des Startpunktes befindest.",
            style: medium18sp.copyWith(color: blackColor),
          ),
        ]),
      ),
      SizedBox(height: 30),
      RichText(
        textAlign: TextAlign.left,
        text: TextSpan(children: [
          TextSpan(
            text:
                "Ab diesem Zeitpunkt wird die Zeit gezählt, die du für diese Strecke benötigst. Sobald du um Ziel bist, wird deine Rundenzeit automatisch per GPS erfasst und in die Rangliste eingetragen",
            style: medium18sp.copyWith(color: blackColor),
          ),
        ]),
      ),
      SizedBox(height: 16),
      Text(
        'Na dann - zeig uns, was deine Wadln hergeben!',
        style: title18sp,
        textAlign: TextAlign.left,
      ),
    ],
  );
}
