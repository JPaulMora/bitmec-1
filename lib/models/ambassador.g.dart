// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ambassador.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ambassador _$AmbassadorFromJson(Map<String, dynamic> json) {
  return Ambassador(
    id: json['id'] as int,
    email: json['email'] as String,
    password: json['password'] as String,
    oneSignalId: json['one_signal_id'] as String,
    sinchId: json['sinch_id'] as String,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    birthDate: json['birth_date'] as String,
    governmentId: json['government_id'] as String,
    profilePicture: json['profile_picture'] as String,
    phoneNumber: json['phone_number'] as String,
    country: json['country'] as String,
    state: json['state'] as String,
    city: json['city'] as String,
    address: json['address'] as String,
    entity: _entityFromJson(json['entity']),
  )..gender = json['gender'] as bool;
}

Map<String, dynamic> _$AmbassadorToJson(Ambassador instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'one_signal_id': instance.oneSignalId,
      'sinch_id': instance.sinchId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'birth_date': instance.birthDate,
      'gender': instance.gender,
      'government_id': instance.governmentId,
      'profile_picture': instance.profilePicture,
      'phone_number': instance.phoneNumber,
      'country': instance.country,
      'state': instance.state,
      'city': instance.city,
      'address': instance.address,
      'entity': _entityToJson(instance.entity),
    };
