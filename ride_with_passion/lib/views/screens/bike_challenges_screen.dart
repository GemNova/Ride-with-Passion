import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ride_with_passion/services/routes_repository.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:ride_with_passion/views/view_models/home_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:ride_with_passion/models/route.dart';

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
            child: StreamBuilder(
              stream:  RoutesRepository().routes,
              builder: (BuildContext context,
                  AsyncSnapshot<List<ChallengeRoute>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                    itemBuilder: (contxt, index) {
                      return InkWell(
                          onTap: (){
                            model.onChallengeDetailButtonPressed(snapshot.data[index]);
                          },
                          child: _buildBikeChallenge(snapshot.data[index]));
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            )),
      ),
    );
  }

  _buildBikeChallenge(ChallengeRoute route) {
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
                        route.images.first,
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
                  Text(route.name,
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
                        route.difficulty,
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
