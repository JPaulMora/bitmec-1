// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalCondition _$MedicalConditionFromJson(Map<String, dynamic> json) {
  return MedicalCondition(
    id: json['id'] as int,
    condition: json['condition'] as String,
    diagnosisDate: json['diagnosis_date'] as String,
    diagnosingDoctor: json['diagnosing_doctor'] as String,
    patient: json['patient'] as int,
  )..images = (json['images'] as List)
          ?.map((e) =>
              e == null ? null : ImageDB.fromJson(e as Map<String, dynamic>))
          ?.toList() ??
      [];
}

Map<String, dynamic> _$MedicalConditionToJson(MedicalCondition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'condition': instance.condition,
      'diagnosis_date': instance.diagnosisDate,
      'diagnosing_doctor': instance.diagnosingDoctor,
      'images': instance.images,
      'patient': instance.patient,
    };
