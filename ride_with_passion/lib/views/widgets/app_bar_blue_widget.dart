import 'package:flutter/material.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/services/firebase_service.dart';
import 'package:ride_with_passion/services/routes_repository.dart';
import 'package:ride_with_passion/styles.dart';

class AppBarBlueWidget extends AppBar {
  AppBarBlueWidget({Key key})
      : super(
          key: key,
          backgroundColor: textColorSecondary,
          elevation: 0,
          title: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(children: [
              TextSpan(
                text: 'BIKE   ',
                style: title18sp.copyWith(color: accentColor),
              ),
              TextSpan(
                text: 'CHALLENGE',
                style: title18sp.copyWith(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 2),
              ),
            ]),
          ),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          actions: <Widget>[
            // IconButton(
            //   icon: Icon(
            //     Icons.menu,
            //     color: Colors.white,
            //   ),
            //   onPressed: () =>
            //       {} /*getIt<FirebaseService>()
            //       .copyRoute(getIt<RoutesRepository>().routes.value[0])*/
            //   ,
            // )
          ],
        );
}
