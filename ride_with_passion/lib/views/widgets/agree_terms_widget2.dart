import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:ride_with_passion/function_utils.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:ride_with_passion/views/view_models/register_view_model.dart';

class AgreeTermsWidget2 extends ProviderWidget<RegisterViewModel> {
  final agbPressRecognizer = TapGestureRecognizer();
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
                text: 'Ich stimme den ',
                style: TextStyle(color: Colors.grey[900]),
              ),
              TextSpan(
                recognizer: agbPressRecognizer
                  ..onTap =
                      () => FunctionUtils.launchURL("https://www.tt.com/agb "),
                text: 'AGB',
                style: TextStyle(
                    color: accentColor, decoration: TextDecoration.underline),
              ),
              TextSpan(
                text: " für das TT Gewinnspiel zu.",
                style: TextStyle(color: Colors.grey[900]),
              ),
            ]),
          ),
        )
      ],
    );
  }
}
