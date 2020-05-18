import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_widget.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:ride_with_passion/views/view_models/register_view_model.dart';

class AgreeTermsWidget extends ProviderWidget<RegisterViewModel> {
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
          child: Text(
            'Ich erkläre mich mit der Speicherung meiner Daten zur Abwicklung meiner Anfrage einverstanden.',
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            textAlign: TextAlign.left,
          ),
        )
      ],
    );
  }
}
