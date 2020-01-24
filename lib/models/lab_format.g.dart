// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lab_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabFormat _$LabFormatFromJson(Map<String, dynamic> json) {
  return LabFormat(
    id: json['id'] as int,
    name: json['name'] as String,
    lowMeasurement: (json['low_measurement'] as num)?.toDouble(),
    highMeasurement: (json['high_measurement'] as num)?.toDouble(),
    units: json['units'] == null ? null : LabUnits.fromJson(json['units']),
  );
}

Map<String, dynamic> _$LabFormatToJson(LabFormat instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'low_measurement': instance.lowMeasurement,
      'high_measurement': instance.highMeasurement,
      'units': instance.units?.toJson(),
    };
