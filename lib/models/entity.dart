import 'package:json_annotation/json_annotation.dart';

part 'entity.g.dart';

@JsonSerializable()
class Entity {
  int id;
  String name;
  String email;
  @JsonKey(name: 'phone_number') String phoneNumber;
  String country;
  String state;
  String city;
  String address;
  @JsonKey(name: 'bitmec_ambassador') bool bitmecAmbassador;
  @JsonKey(name: 'bitmec_doctors') bool bitmecDoctors;
  bool active;

  Entity({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.country,
    this.state,
    this.city,
    this.address,
    this.bitmecAmbassador,
    this.bitmecDoctors,
    this.active,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => _$EntityFromJson(json);

  Map<String, dynamic> toJson() => _$EntityToJson(this);
}
