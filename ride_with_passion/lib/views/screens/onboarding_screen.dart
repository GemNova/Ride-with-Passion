import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_passion/function_utils.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:ride_with_passion/views/widgets/custom_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(239, 236, 219, 1),
            ),
            width: double.infinity,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'BIKE ',
                      style: title24sp.copyWith(color: accentColor),
                    ),
                    TextSpan(
                      text: 'CHALLENGE',
                      style: title24sp,
                    ),
                    TextSpan(
                      text: ".TIROL",
                      style: title24sp.copyWith(color: textColorSecondary),
                    ),
                  ]),
                ),
              ),
            ),
          ),
          Center(
              child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Mit der',
                            style: TextStyle(
                              fontSize: 21,
                              color: textColorSecondary,
                              letterSpacing: 0.5,
                            )),
                        TextSpan(
                            text: ' bikechallenge.tirol ',
                            style: TextStyle(
                              fontSize: 21,
                              color: accentColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            )),
                        TextSpan(
                          text:
                              "hat man die einzigartige Möglichkeit sich auf einer realen Strecke mit Mountainbike- bzw. Rennrad-Profis zu messen. Im direkten Vergleich sieht man, wie nahe man an die Bestzeiten herankommt oder diese sogar noch unterbietet. Sei dabei und zeig, wie schnell du den Berg hinauf radeln kannst!",
                          style: TextStyle(
                            fontSize: 21,
                            color: textColorSecondary,
                            letterSpacing: 0.5,
                          ),
                        ),
                        TextSpan(
                            text: '\n\nMehr Infos unter: ',
                            style: TextStyle(
                              fontSize: 21,
                              color: textColorSecondary,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            )),
                        TextSpan(
                            text: ' www.bikechallenge.tirol',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => FunctionUtils.launchURL(
                                  "https://www.bikechallenge.tirol"),
                            style: TextStyle(
                              fontSize: 21,
                              color: accentColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            )),
                      ])))),
          Padding(
            padding: const EdgeInsets.all(36.0),
            child: CustomButton(
              text: "Los geht's",
              onPressed: Get.back,
            ),
          )
        ],
      ),
    );
  }
}
