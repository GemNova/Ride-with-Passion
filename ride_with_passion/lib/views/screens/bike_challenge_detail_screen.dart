import 'package:cached_network_image/cached_network_image.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:ride_with_passion/models/route.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:ride_with_passion/views/view_models/bike_challenges_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:ride_with_passion/views/widgets/app_bar_blue_widget.dart';
import 'package:ride_with_passion/views/widgets/custom_button.dart';
import 'package:ride_with_passion/views/widgets/custom_card.dart';
import 'package:ride_with_passion/views/widgets/custom_loading_indicator.dart';
import 'package:ride_with_passion/views/widgets/sponsor_card_widget.dart';
import 'package:ride_with_passion/views/widgets/text_title_top_widget.dart';
import 'package:ride_with_passion/views/widgets/timer_widget.dart';
import 'package:ride_with_passion/views/widgets/track_name_type_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BikeChallangesDetailScreen extends StatelessWidget {
  BikeChallangesDetailScreen(this.route, {Key key}) : super(key: key);
  final ChallengeRoute route;
  final ScrollController _rrectController = ScrollController();

  @override
  Widget build(BuildContext contex) {
    return ViewModelProvider<BikeChallengesViewModel>.withConsumer(
      viewModelBuilder: () => BikeChallengesViewModel(this.route),
      builder: (context, model, child) => Scaffold(
        appBar: AppBarBlueWidget(),
        body: Container(
          color: backgroundColor,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 32),
          child: model.isMapView
              ? _mapViewBody(model, context)
              : SingleChildScrollView(
                  child: _challengeDetailBody(context, model)),
        ),
      ),
    );
  }

  Widget _challengeDetailBody(
      BuildContext context, BikeChallengesViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TimerWidget(
          streamTimer: model.timerCounter,
          running: model.running,
        ),
        _buildChallengeDiffType(),
        _headerButton(model, route),
        _informationCard(context, model, route),
        SponsorCardWidget(route: route),
        _graphCard(route, model),
        _rankCard(route, model)
      ],
    );
  }

  Widget _buildChallengeDiffType() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TrackNameTypeWidget(route),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 60),
            child: Text(
              route.name,
              style: title32sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerButton(BikeChallengesViewModel model, ChallengeRoute route) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 16,
        ),
        FutureBuilder(
          future: model.isOngoingChallengeSame(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data) {
                return CustomButton(
                  text: 'BIKE CHALLENGE STARTEN',
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 22),
                  onPressed: () =>
                      model.onBikeChallengeStartPressed(this.route),
                );
              }
            }
            return CustomButton(
              text: 'Es läuft bereits eine andere Challenge',
              backGroundColor: disabledColor,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              onPressed: null,
            );
          },
        ),
        mediumSpace,
        model.isDownloading
            ? CustomLoadingIndicator()
            : CustomButton(
                text: 'GPX DATEI HERUNTERLADEN',
                backGroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 22),
                textColor: textColorSecondary,
                borderColor: textColorSecondary,
                onPressed: () => model.onDownloadGpxFilePressed(),
              ),
        mediumSpace,
      ],
    );
  }

  Widget _informationCard(BuildContext context, BikeChallengesViewModel model,
      ChallengeRoute route) {
    return CustomCard(
      radius: 30,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Text(
              'Informationen\nzur Strecke',
              style: title32sp.copyWith(
                  color: textColorSecondary, fontWeight: FontWeight.bold),
            ),
          ),
          CarouselSlider.builder(
            initialPage: model.chosenIndex,
            enableInfiniteScroll: false,
            onPageChanged: (int index) => model.carouselSlide(index),
            itemCount: route.images.length,
            aspectRatio: 16 / 11,
            viewportFraction: 1.0,
            itemBuilder: (BuildContext context, int itemIndex) =>
                CachedNetworkImage(
              imageUrl: route.images[itemIndex],
              fit: BoxFit.cover,
              placeholder: (context, url) => Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation(accentColor),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          route.images.isNotEmpty
              ? _buildIndicator(model, context)
              : Container(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              route.description,
              style: small14sp.copyWith(color: textColorSecondary, height: 1.5),
            ),
          ),
          bigSpace,
        ],
      ),
    );
  }

  _buildIndicator(BikeChallengesViewModel model, BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 30,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: route.images.length,
        itemBuilder: (_, index) {
          return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: model.chosenIndex == index
                    ? Color.fromRGBO(0, 0, 0, 0.9)
                    : Color.fromRGBO(0, 0, 0, 0.4)),
          );
        },
      ),
    );
  }

  Widget iconButton({Function onPressed, IconData icon}) {
    return Material(
      color: Colors.transparent,
      child: IconButton(
        iconSize: 50,
        onPressed: onPressed,
        disabledColor: Colors.grey,
        icon: Icon(
          icon,
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }

  Widget _graphCard(ChallengeRoute route, BikeChallengesViewModel model) {
    return CustomCard(
      radius: 30,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Streckeninfos',
                style: title32sp.copyWith(
                    color: textColorSecondary, fontWeight: FontWeight.bold),
              ),
            ),
            Stack(
              children: <Widget>[
                CachedNetworkImage(imageUrl: route.heightProfile),
              ],
            ),
            Divider(
              height: 30,
              color: accentColor,
              thickness: 1,
            ),
            smallSpace,
            CustomButton(
              padding: EdgeInsets.symmetric(vertical: 20),
              onPressed: () {
                model.toggleMapViewPage(true);
              },
              borderColor: textColorSecondary,
              elevation: 0,
              text: 'KARTE ANZEIGEN',
              backGroundColor: Colors.white,
              textColor: textColorSecondary,
              textFontSize: 20,
            ),
            smallSpace,
            Divider(
              height: 30,
              color: accentColor,
              thickness: 1,
            ),
            _textData('Schwierigkeit', route.difficulty),
            dividerOrangeText(),
            _textData('Streckenlänge', '${route.length} Km'),
            dividerOrangeText(),
            _textData('Dauer',
                '${route.durationMin} bis ${route.durationMax} Minuten'),
            dividerOrangeText(),
            _textData('Höhenunterschied', '${route.elevationGain} m'),
            dividerOrangeText(),
            _textData('Durchschnittliche Steigung', '${route.averageSlope} %'),
            dividerOrangeText(),
            _textData('Koordinaten Start',
                '${route.startCoordinates.lat}, ${route.startCoordinates.lon}'),
            dividerOrangeText(),
            _textData('Koordinaten End',
                '${route.startCoordinates.lat}, ${route.startCoordinates.lon}'),
          ],
        ),
      ),
    );
  }

  Widget _textData(String label, String value) {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(children: [
        TextSpan(
          text: '$label: ',
          style: title18cb,
        ),
        TextSpan(
          text: value,
          style: medium18cb,
        ),
      ]),
    );
  }

  Divider dividerOrangeText() {
    return Divider(
      color: accentColor,
      thickness: 1,
    );
  }

  Widget _rankCard(ChallengeRoute route, BikeChallengesViewModel model) {
    return CustomCard(
      radius: 30,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: <Widget>[
                  Text(
                    'Rangliste',
                    style: title32sp.copyWith(color: textColorSecondary),
                  ),
                ],
              ),
            ),
            mediumSpace,
            _buildChoiceChip(model),
            mediumSpace,
            Container(
              constraints: BoxConstraints(minHeight: 50, maxHeight: 170),
              child: _rankData(route, model),
            ),
            bigSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceChip(BikeChallengesViewModel model) {
    return Wrap(
      children: [
        ChoiceChip(
          label: Text(
            'MTB',
            style: small14sp.copyWith(color: Colors.white),
          ),
          selected: model.choiceValue == 'Bike',
          onSelected: (selected) => model.onChipSelected('Bike'),
          backgroundColor: disabledColor,
          selectedColor: textColorSecondary,
        ),
        mediumSpace,
        ChoiceChip(
          label: Text(
            'E-Bike',
            style: small14sp.copyWith(color: Colors.white),
          ),
          selected: model.choiceValue == 'E-Bike',
          onSelected: (selected) => model.onChipSelected('E-Bike'),
          backgroundColor: disabledColor,
          selectedColor: textColorSecondary,
        )
      ],
    );
  }

  Widget _rankData(ChallengeRoute route, BikeChallengesViewModel model) {
    print('filtered rank ${model.filteredRankList.length}');
    return DraggableScrollbar.rrect(
      controller: _rrectController,
      alwaysVisibleScrollThumb: true,
      backgroundColor: accentColor,
      child: ListView.separated(
          controller: _rrectController,
          padding: EdgeInsets.only(right: 20),
          itemCount: model.filteredRankList.length,
          separatorBuilder: (context, index) {
            return dividerOrangeText();
          },
          itemBuilder: (context, index) {
            // if (model.filteredRankList.length != 1 &&
            //     (index == 0 || index == model.filteredRankList.length + 1)) {
            //   return Container(); // zero height: not visible
            // }
            final rank = model.filteredRankList[index];
            return Column(
              children: <Widget>[
                if (index == 0) dividerOrangeText(),
                Row(
                  children: <Widget>[
                    Text(
                      '${index + 1}.',
                      style: title18cb,
                    ),
                    mediumSpace,
                    Expanded(
                      child: Text(
                        rank.userName,
                        style: medium18cb,
                      ),
                    ),
                    Text(
                      '${Duration(milliseconds: rank.trackedTime).toString().split('.')[0]}',
                      style:
                          medium18sp.copyWith(color: blackColor, fontSize: 16),
                    )
                  ],
                ),
              ],
            );
          }),
    );
  }

  Widget _mapViewBody(BikeChallengesViewModel model, BuildContext context) {
    return Column(
      children: <Widget>[
        mediumSpace,
        TextTitleTopWidget(),
        smallSpace,
        ChallengeNameTextWidget(challengeName: route.name),
        Spacer(),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: PhotoView(
              backgroundDecoration: BoxDecoration(color: Colors.transparent),
              maxScale: PhotoViewComputedScale.covered * 2.0,
              minScale: PhotoViewComputedScale.contained * 0.8,
              initialScale: PhotoViewComputedScale.contained,
              imageProvider: CachedNetworkImageProvider(route.mapImage)),
        ),
        Spacer(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 250,
            height: 60,
            child: CustomButton(
              text: 'ZURÜCK',
              icon: Icons.keyboard_arrow_left,
              padding: EdgeInsets.symmetric(vertical: 12),
              backGroundColor: accentColor,
              onPressed: () => model.toggleMapViewPage(false),
            ),
          ),
        ),
      ],
    );
  }
}
