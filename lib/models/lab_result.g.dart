// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lab_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabResult _$LabResultFromJson(Map<String, dynamic> json) {
  return LabResult(
    id: json['id'] as int,
    measurement: json['measurement'] as int,
    units: json['units'] == null ? null : LabUnits.fromJson(json['units']),
    timestamp: json['timestamp'] as String,
  );
}

Map<String, dynamic> _$LabResultToJson(LabResult instance) => <String, dynamic>{
      'id': instance.id,
      'measurement': instance.measurement,
      'units': instance.units?.toJson(),
      'timestamp': instance.timestamp,
    };
