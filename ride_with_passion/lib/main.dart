import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/router.dart';
import 'package:ride_with_passion/services/auth_service.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:ride_with_passion/views/screens/home_screen.dart';
import 'package:ride_with_passion/views/screens/login_screen.dart';
import 'package:ride_with_passion/locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (_) => runApp(App()),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //TODO change name
      title: 'Ride with Passion',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      navigatorKey: Get.key,
      onGenerateRoute: Router.generateRoute,
      theme: ThemeData(
        primaryTextTheme: Theme.of(context).textTheme.apply(
              bodyColor: textColor,
              displayColor: textColor,
            ),
        primaryColor: primaryColor,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: textColor,
              displayColor: textColor,
            ),
      ),
      home: StreamBuilder(
        stream: getIt<AuthService>().isLoggedIn.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data == true ? HomeScreen() : LoginScreen();
          } else {
            //TODO add Splashscreen here if needed
            return Container(color: Colors.white);
          }
        },
      ),
    );
  }
}
