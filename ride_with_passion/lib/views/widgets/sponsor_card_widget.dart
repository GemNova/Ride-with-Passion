import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ride_with_passion/models/route.dart';
import 'package:ride_with_passion/views/widgets/custom_card.dart';

class SponsorCardWidget extends StatelessWidget {
  final ChallengeRoute route;

  const SponsorCardWidget({Key key, this.route}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      radius: 30,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: CachedNetworkImage(imageUrl: route?.sponsorImage ?? ""),
      ),
    );
  }
}
