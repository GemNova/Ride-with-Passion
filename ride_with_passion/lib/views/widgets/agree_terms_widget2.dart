import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
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
          child: Text(
            'Ich habe die AGB der Tiroler Tageszeitung verstanden',
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            textAlign: TextAlign.left,
          ),
        )
      ],
    );
  }
}
