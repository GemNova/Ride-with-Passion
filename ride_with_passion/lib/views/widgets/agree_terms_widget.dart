import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:ride_with_passion/function_utils.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:ride_with_passion/views/view_models/register_view_model.dart';

class AgreeTermsWidget extends ProviderWidget<RegisterViewModel> {
  final agbPressRecognizer = TapGestureRecognizer();
  final datenSchutzRecognizer = TapGestureRecognizer();
  @override
  Widget build(BuildContext context, RegisterViewModel model) {
    return Row(
      children: <Widget>[
        Checkbox(
          activeColor: accentColor,
          value: model.tcValue,
          onChanged: (value) {
            model.setTcValue(value);
          },
        ),
        Expanded(
          child: RichText(
            textAlign: TextAlign.left,
            maxLines: 4,
            text: TextSpan(children: [
              TextSpan(
                text: 'Ich stimme den ',
                style: TextStyle(color: Colors.grey[900]),
              ),
              TextSpan(
                recognizer: agbPressRecognizer
                  ..onTap = () => FunctionUtils.launchURL(
                      "https://www.bikechallenge.tirol/agb"),
                text: 'AGB',
                style: TextStyle(
                    color: accentColor, decoration: TextDecoration.underline),
              ),
              TextSpan(
                  text:
                      ", sowie der Verarbeitung meiner Daten zum Zweck der Registrierung gemäß ",
                  style: TextStyle(color: Colors.grey[900])),
              TextSpan(
                recognizer: datenSchutzRecognizer
                  ..onTap = () => FunctionUtils.launchURL(
                      "https://www.bikechallenge.tirol/datenschutz "),
                text: 'Datenschutzerklärung',
                style: TextStyle(
                    color: accentColor, decoration: TextDecoration.underline),
              ),
              TextSpan(
                text: " zu.",
                style: TextStyle(color: Colors.grey[900]),
              ),
            ]),
          ),
        )
      ],
    );
  }
}
