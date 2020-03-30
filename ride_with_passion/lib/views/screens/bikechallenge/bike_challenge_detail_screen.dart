import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ride_with_passion/models/route.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:ride_with_passion/views/view_models/bike_challenges_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:ride_with_passion/views/widgets/custom_button.dart';
import 'package:ride_with_passion/views/widgets/custom_card.dart';
import 'package:ride_with_passion/views/widgets/custom_loading_indicator.dart';

class BikeChallangesDetailScreen extends StatelessWidget {
  BikeChallangesDetailScreen(this.route, {Key key}) : super(key: key);
  final ChallengeRoute route;
  Widget _headerButton(BikeChallengesViewModel model, ChallengeRoute route) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 16,
        ),
        Text(
          route.name,
          style: TextStyle(
            color: accentColor,
            fontSize: 24,
            letterSpacing: -0.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        CustomButton(
          text: 'BIKE CHALLENGE STARTEN',
          icon: Icons.card_giftcard,
          onPressed: model.onBikeChallengeStartPressed,
        ),
        CustomButton(
          text: 'GPX DATEI HERUNTERLADEN',
          icon: Icons.card_giftcard,
          backGroundColor: blackColor,
        ),
      ],
    );
  }

  Widget _informationCard(BuildContext context, BikeChallengesViewModel model,
      ChallengeRoute route) {
    return CustomCard(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Information',
                style: medium20sp.copyWith(
                    color: blackColor, fontWeight: FontWeight.bold),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 16 / 11,
                  child: PageView(
                      controller: model.pageController,
                      children: route.images
                          .map((x) => CachedNetworkImage(imageUrl: x))
                          .toList()),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    iconButton(
                        onPressed: () {
                          model.onCrouselIconPressed(0);
                        },
                        icon: Icons.keyboard_arrow_left),
                    iconButton(
                        onPressed: () {
                          model.onCrouselIconPressed(1);
                        },
                        icon: Icons.keyboard_arrow_right)
                  ],
                ),
              ],
            ),
            Text(route.description)
          ],
        ),
      ),
    );
  }

  Widget iconButton({Function onPressed, IconData icon}) {
    return Material(
      color: Colors.transparent,
      child: IconButton(
        iconSize: 50,
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }

  Widget _sponsorCard(ChallengeRoute route) {
    return CustomCard(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: CachedNetworkImage(imageUrl: route.sponsorImage),
      ),
    );
  }

  Widget _graphCard(ChallengeRoute route, BikeChallengesViewModel model) {
    return CustomCard(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: <Widget>[
                  Text(
                    'Streckeninfos',
                    style: medium20sp.copyWith(
                        color: blackColor, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  CustomButton(
                    onPressed: () {
                      model.toggleMapViewPage(true);
                    },
                    text: 'KARTE ANZEIGEN',
                    icon: Icons.card_giftcard,
                    backGroundColor: brownColor,
                    textFontSize: 12,
                  ),
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                CachedNetworkImage(imageUrl: route.heightProfile),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _data(route)
          ],
        ),
      ),
    );
  }

  Widget _data(ChallengeRoute route) {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            color: Colors.grey.shade400,
            child: Text(
              'Schwierigkeit',
              style: medium18sp.copyWith(
                  color: blackColor, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 8),
            color: Colors.grey.shade400,
            child: Text(
              'Mittel',
              style: medium18sp.copyWith(
                  color: blackColor, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ]),
        _tabelRow("Streckenlänge", '${route.length} Km'),
        _tabelRow(
            "Dauer", "${route.durationMin} bis ${route.durationMax} Minuten"),
        _tabelRow("Höhenunterschied", "${route.elevationGain} m"),
        _tabelRow("Durchschnittlich", "${route.averageSlope} %"),
        _tabelRow("Koordinaten Start",
            "${route.endCoordinates.lat}, ${route.endCoordinates.lon}"),
        _tabelRow("Koordinaten Ende",
            "${route.startCoordinates.lat}, ${route.startCoordinates.lon}"),
      ],
    );
  }

  TableRow _tabelRow(String name, dynamic value) {
    return TableRow(children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          name,
          style: medium18sp.copyWith(color: blackColor, fontSize: 16),
        ),
      ),
      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            value.toString(),
            style: medium18sp.copyWith(color: blackColor, fontSize: 16),
          ),
        )
      ]),
    ]);
  }

  Widget _rankCard(ChallengeRoute route) {
    return CustomCard(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: <Widget>[
                  Text(
                    'Rangliste',
                    style: medium20sp.copyWith(
                        color: blackColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              constraints: BoxConstraints(minHeight: 50, maxHeight: 130),
              child: SingleChildScrollView(
                child: _rankData(route),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _rankData(ChallengeRoute route) {
    route.rankList.sort((x, y) => x.trackedTime.compareTo(y.trackedTime));
    List<TableRow> list = [];
    list.add(
      TableRow(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Rang',
            style: medium18sp.copyWith(
                color: blackColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Name',
            style: medium18sp.copyWith(
                color: blackColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Zeit',
            style: medium18sp.copyWith(
                color: blackColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ]),
    );
    list.addAll(route.rankList.map((x) {
      return _rankListRow(
          route.rankList.indexOf(x) + 1, x.userName, x.trackedTime);
    }).toList());
    return Table(border: TableBorder.all(), children: list);
  }

  TableRow _rankListRow(int index, String name, int rank) {
    return TableRow(children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          '$index',
          style: medium18sp.copyWith(color: blackColor, fontSize: 16),
        ),
      ),
      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            name,
            style: medium18sp.copyWith(color: blackColor, fontSize: 16),
          ),
        )
      ]),
      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '${Duration(milliseconds: rank).toString().split('.')[0]}',
            style: medium18sp.copyWith(color: blackColor, fontSize: 16),
          ),
        )
      ]),
    ]);
  }

  Widget _challengeDetailBody(
      BuildContext context, BikeChallengesViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _headerButton(model, route),
        _informationCard(context, model, route),
        _sponsorCard(route),
        _graphCard(route, model),
        _rankCard(route)
      ],
    );
  }

  Widget _mapViewBody(BikeChallengesViewModel model) {
    return Column(
      children: <Widget>[
        Text(
          route.name,
          style: TextStyle(
            color: accentColor,
            fontSize: 24,
            letterSpacing: -0.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        CachedNetworkImage(imageUrl: route.mapImage),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: CustomButton(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              onPressed: () {
                model.toggleMapViewPage(false);
              },
              text: 'Back',
              icon: Icons.keyboard_arrow_left),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext contex) {
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
          child: StreamBuilder(
            stream: model.isMapViewOpen,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              return snapshot.data
                  ? _mapViewBody(model)
                  : SingleChildScrollView(
                      child: route == null
                          ? CustomLoadingIndicator()
                          : _challengeDetailBody(context, model),
                    );
            },
          ),
        ),
      ),
    );
  }
}
