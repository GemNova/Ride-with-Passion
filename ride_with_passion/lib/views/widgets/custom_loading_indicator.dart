import 'package:flutter/material.dart';
import 'package:ride_with_passion/styles.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: accentColor,
        valueColor: AlwaysStoppedAnimation(Colors.white),
      ),
    );
  }
}
