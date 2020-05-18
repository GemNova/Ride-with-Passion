import 'package:flutter/material.dart';
import 'package:ride_with_passion/styles.dart';

class MainTitleTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(children: [
        TextSpan(
          text: 'BIKE ',
          style: title18sp.copyWith(color: accentColor),
        ),
        TextSpan(
          text: 'CHALLENGE',
          style: title18sp,
        ),
        TextSpan(
          text: ".TIROL",
          style: title18sp.copyWith(color: textColorSecondary),
        ),
      ]),
    );
  }
}
