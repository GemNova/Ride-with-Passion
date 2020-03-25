import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:ride_with_passion/views/view_models/home_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';

class BikeChallangesScreen extends StatelessWidget {
  const BikeChallangesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
      viewModel: HomeViewModel(),
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              InkWell(
                child: _buildBikeChallenge(),
                onTap: model.onBikeChallengePressed,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildBikeChallenge() {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 240,
              child: Material(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                color: Colors.grey[300],
                elevation: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://firebasestorage.googleapis.com/v0/b/ride-with-passion.appspot.com/o/csm_Radfahren-als-Berglauftrianing-SI_4b1a89d418.png?alt=media&token=1e8c9063-2dd2-4ecc-9ce5-93b54866263a",
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
            Positioned(
              top: 20,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Von Kals zum Lucknerhaus",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        letterSpacing: -0.5,
                        fontWeight: FontWeight.bold),
                  ),
                  smallSpace,
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.orange[400],
                        borderRadius: BorderRadius.circular(40)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 2),
                      child: Text(
                        "MITTEL",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          height: 60,
          color: accentColor,
          width: double.infinity,
          child: Center(
            child: Text(
              "Details anzeigen",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  letterSpacing: -0.5,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
