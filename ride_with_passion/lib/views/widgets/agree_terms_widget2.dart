import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:ride_with_passion/function_utils.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:ride_with_passion/views/view_models/register_view_model.dart';

class AgreeTermsWidget2 extends ProviderWidget<RegisterViewModel> {
  @override
  Widget build(BuildContext context, RegisterViewModel model) {
    return Row(
      children: <Widget>[
        Checkbox(
          activeColor: accentColor,
          value: model.tc1Value,
          onChanged: model.setTc1Value,
        ),
        Expanded(
          child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(children: [
              TextSpan(
                text: 'Ja, ich möchte an dem ',
                style: TextStyle(color: Colors.grey[900]),
              ),
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () => FunctionUtils.launchURL(
                      "https://club.tt.com/vorteile/30734046/laura-stigger-bike-challenge-gewinnspiel"),
                text: 'Gewinnspiel der Tiroler Tageszeitung',
                style: TextStyle(
                    color: accentColor, decoration: TextDecoration.underline),
              ),
              TextSpan(
                text:
                    " teilnehmen und bin einverstanden, dass meine personenbezogenen Daten an die Tiroler Tageszeitung (Schlüsselverlag J.S. Moser GmbH, Brunecker Straße 3, 6020 Innsbruck) weitergegeben werden. ",
                style: TextStyle(color: Colors.grey[900]),
              ),
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap =
                      () => FunctionUtils.launchURL("https://www.tt.com/agb"),
                text: 'TT AGB',
                style: TextStyle(
                    color: accentColor, decoration: TextDecoration.underline),
              ),
            ]),
          ),
        )
      ],
    );
  }
}
