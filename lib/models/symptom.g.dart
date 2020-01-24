// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symptom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Symptom _$SymptomFromJson(Map<String, dynamic> json) {
  return Symptom(
    id: json['id'] as int,
    type: json['type'] as int,
    location: json['location'] as int,
    severity: json['severity'] as int,
    onset: json['onset'] as String,
    reported: json['reported'] as String,
    timestamp: json['timestamp'] as String,
  );
}

Map<String, dynamic> _$SymptomToJson(Symptom instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'location': instance.location,
      'severity': instance.severity,
      'onset': instance.onset,
      'reported': instance.reported,
      'timestamp': instance.timestamp,
    };
