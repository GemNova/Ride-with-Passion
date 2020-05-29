import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ride_with_passion/styles.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    Key key,
    @required this.text,
    this.textColor = Colors.white,
    this.backGroundColor = accentColor,
    this.borderColor = Colors.transparent,
    this.elevation = 1.0,
    this.icon,
    this.onPressed,
    this.textFontSize = 20,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
  }) : super(key: key);
  final Color backGroundColor;
  final String text;
  final Color textColor;
  final double elevation;
  final Color borderColor;
  final IconData icon;
  final Function onPressed;
  final double textFontSize;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(35),
        ),
        side: BorderSide(color: borderColor),
      ),
      color: backGroundColor,
      elevation: elevation,
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Container(
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            icon == null
                ? SizedBox.shrink()
                : Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                      ),
                    ),
                  ),
            Expanded(
              child: Center(
                child: AutoSizeText(
                  text,
                  minFontSize: 10,
                  maxFontSize: 24,
                  maxLines: 1,
                  style: TextStyle(
                    color: textColor,
                    fontSize: textFontSize,
                    letterSpacing: -0.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
