// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consultation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Consultation _$ConsultationFromJson(Map<String, dynamic> json) {
  return Consultation(
    id: json['id'] as int,
    name: json['name'] as String,
    patient: json['patient'] as int,
    active: json['active'] as bool,
    timestamp: json['timestamp'] as String,
  );
}

Map<String, dynamic> _$ConsultationToJson(Consultation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'patient': instance.patient,
      'active': instance.active,
      'timestamp': instance.timestamp,
    };
