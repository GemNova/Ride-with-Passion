import 'package:json_annotation/json_annotation.dart';

part 'partner.g.dart';

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class Partner {
  String image;
  String link;

  Partner({
    this.image,
    this.link,
  });
  factory Partner.fromJson(Map<String, dynamic> json) =>
      _$PartnerFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerToJson(this);
}
