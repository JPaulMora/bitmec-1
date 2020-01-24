// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vital_sign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VitalSign _$VitalSignFromJson(Map<String, dynamic> json) {
  return VitalSign(
    id: json['id'] as int,
    weight: (json['weight'] as num)?.toDouble(),
    height: (json['height'] as num)?.toDouble(),
    systolicPressure: (json['systolic_pressure'] as num)?.toDouble(),
    diastolicPressure: (json['diastolic_pressure'] as num)?.toDouble(),
    heartRate: (json['heart_rate'] as num)?.toDouble(),
    temperature: (json['temperature'] as num)?.toDouble(),
    glucose: (json['glucose'] as num)?.toDouble(),
    oxygen: (json['oxygen'] as num)?.toDouble(),
    timestamp: json['timestamp'] as String,
    consultation: json['consultation'] as int,
  );
}

Map<String, dynamic> _$VitalSignToJson(VitalSign instance) => <String, dynamic>{
      'id': instance.id,
      'weight': instance.weight,
      'height': instance.height,
      'systolic_pressure': instance.systolicPressure,
      'diastolic_pressure': instance.diastolicPressure,
      'heart_rate': instance.heartRate,
      'temperature': instance.temperature,
      'glucose': instance.glucose,
      'oxygen': instance.oxygen,
      'timestamp': instance.timestamp,
      'consultation': instance.consultation,
    };
