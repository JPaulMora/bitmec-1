// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laboratory_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaboratoryOrder _$LaboratoryOrderFromJson(Map<String, dynamic> json) {
  return LaboratoryOrder(
    id: json['id'] as int,
    doctor: json['doctor'] == null ? null : Doctor.fromJson(json['doctor']),
    labFormat: json['lab_format'] == null
        ? null
        : LabFormat.fromJson(json['lab_format']),
    timestamp: json['timestamp'] as String,
    results: (json['results'] as List)
        ?.map((e) => e == null ? null : LabResult.fromJson(e))
        ?.toList(),
  );
}

Map<String, dynamic> _$LaboratoryOrderToJson(LaboratoryOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctor': instance.doctor?.toJson(),
      'lab_format': instance.labFormat?.toJson(),
      'timestamp': instance.timestamp,
      'results': instance.results?.map((e) => e?.toJson())?.toList(),
    };
