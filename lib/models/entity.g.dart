// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entity _$EntityFromJson(Map<String, dynamic> json) {
  return Entity(
    id: json['id'] as int,
    name: json['name'] as String,
    email: json['email'] as String,
    phoneNumber: json['phone_number'] as String,
    country: json['country'] as String,
    state: json['state'] as String,
    city: json['city'] as String,
    address: json['address'] as String,
    bitmecAmbassador: json['bitmec_ambassador'] as bool,
    bitmecDoctors: json['bitmec_doctors'] as bool,
    active: json['active'] as bool,
  );
}

Map<String, dynamic> _$EntityToJson(Entity instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'country': instance.country,
      'state': instance.state,
      'city': instance.city,
      'address': instance.address,
      'bitmec_ambassador': instance.bitmecAmbassador,
      'bitmec_doctors': instance.bitmecDoctors,
      'active': instance.active,
    };
