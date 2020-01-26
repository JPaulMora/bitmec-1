// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_member_condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyMemberCondition _$FamilyMemberConditionFromJson(
    Map<String, dynamic> json) {
  return FamilyMemberCondition(
    id: json['id'] as int,
    relative: json['relative'] as String,
    condition: json['condition'] as String,
    dateDiagnosed: json['date_diagnosed'] as String,
    patient: json['patient'] as int,
  );
}

Map<String, dynamic> _$FamilyMemberConditionToJson(
        FamilyMemberCondition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'relative': instance.relative,
      'condition': instance.condition,
      'date_diagnosed': instance.dateDiagnosed,
      'patient': instance.patient,
    };
