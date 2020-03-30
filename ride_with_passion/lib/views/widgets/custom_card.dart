import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final double radius;
  final double hPadding;
  final double vPadding;
  final EdgeInsetsGeometry margin;
  double blurRadius = 5;
  double spreadRadius = 1;
  double offset = 2;

  CustomCard({
    Key key,
    this.child,
    this.color = Colors.white,
    this.radius = 5,
    this.hPadding = 0,
    this.vPadding = 0,
     this.margin = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: color,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xffa4a4a4),
            offset: Offset(offset, offset),
            blurRadius: blurRadius,
            spreadRadius: spreadRadius,
          ),
        ],
      ),
      child: child,
    );
  }
}
