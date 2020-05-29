import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ride_with_passion/helper/constants.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:ride_with_passion/views/view_models/home_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:ride_with_passion/models/route.dart';
import 'package:ride_with_passion/views/widgets/app_bar_blue_widget.dart';
import 'package:ride_with_passion/views/widgets/timer_widget.dart';
import 'package:ride_with_passion/views/widgets/track_name_type_widget.dart';

class BikeChallangesScreen extends StatelessWidget {
  const BikeChallangesScreen({Key key, this.routeType}) : super(key: key);

  final RouteType routeType;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBarBlueWidget(),
        body: Container(
            color: backgroundColor,
            padding: const EdgeInsets.fromLTRB(24, 4, 24, 32),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TimerWidget(
                    streamTimer: model.timerCounter,
                    running: model.running,
                  ),
                  StreamBuilder(
                    stream: model.getRoutes(routeType),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<ChallengeRoute>> snapshot) {
                      if (snapshot.hasData) {
                        return SingleChildScrollView(
                          child: snapshot.data.length == 0
                              ? _buildEmptyScreen()
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data == null
                                      ? 0
                                      : snapshot.data.length,
                                  itemBuilder: (contxt, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: InkWell(
                                          onTap: () {
                                            model
                                                .onChallengeDetailButtonPressed(
                                                    snapshot.data[index]);
                                          },
                                          child: _buildBikeChallenge(
                                              model, snapshot.data[index])),
                                    );
                                  },
                                ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }

  _buildEmptyScreen() {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Kommt in Kürze!",
        style: title32sp,
      ),
    ));
  }

  _buildBikeChallenge(HomeViewModel model, ChallengeRoute route) {
    return Column(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TrackNameTypeWidget(route),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: Text(
                  route.name,
                  style: title32sp,
                ),
              ),
              smallSpace,
              Container(
                width: double.infinity,
                height: 280,
                child: Material(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  color: Colors.grey[300],
                  elevation: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    child: CachedNetworkImage(
                      imageUrl: route.images.first,
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
                ),
              ),
            ],
          ),
        ),
        smallSpace,
        Container(
          height: 60,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: accentColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Text(
              "DETAILS",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: -0.5,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        bigSpace,
      ],
    );
  }
}
