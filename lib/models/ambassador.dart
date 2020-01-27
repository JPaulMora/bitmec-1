import 'package:json_annotation/json_annotation.dart';

import 'package:bitmec/models.dart';

part 'ambassador.g.dart';

Entity _entityFromJson(json) {
  if (json is Map)
    return Entity.fromJson(json);

  if (json is int)
    return Entity(id: json);

  return Entity();
}

int _entityToJson(Entity entity) {
  return entity.id;
}

@JsonSerializable(explicitToJson: true)
class Ambassador {
  int id;
  String email;
  String password;
  @JsonKey(name: 'one_signal_id') String oneSignalId;
  @JsonKey(name: 'sinch_id') String sinchId;
  @JsonKey(name: 'first_name') String firstName;
  @JsonKey(name: 'last_name') String lastName;
  @JsonKey(name: 'birth_date') String birthDate;
  bool gender;
  @JsonKey(name: 'government_id') String governmentId;
  @JsonKey(name: 'profile_picture') String profilePicture;
  @JsonKey(name: 'phone_number') String phoneNumber;
  String country;
  String state;
  String city;
  String address;
  @JsonKey(fromJson: _entityFromJson, toJson: _entityToJson)
  Entity entity;

  Ambassador({
    this.id,
    this.email,
    this.password,
    this.oneSignalId,
    this.sinchId,
    this.firstName,
    this.lastName,
    this.birthDate,
    this.governmentId,
    this.profilePicture,
    this.phoneNumber,
    this.country,
    this.state,
    this.city,
    this.address,
    this.entity,
  });

  factory Ambassador.fromJson(json) => _$AmbassadorFromJson(json);

  Map toJson() => _$AmbassadorToJson(this);
}
