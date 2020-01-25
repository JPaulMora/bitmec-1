// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Prescription _$PrescriptionFromJson(Map<String, dynamic> json) {
  return Prescription(
    id: json['id'] as int,
    drug: json['drug'] as String,
    dose: json['dose'] as String,
    frequency: json['frequency'] as String,
    prescriptionStartDate: json['prescription_start_date'] as String,
    prescriptionEndDate: json['prescription_end_date'] as String,
    prescribingDoctor: json['prescribing_doctor'] as String,
    historicalCondition: json['historical_condition'] as int,
    historicalOperation: json['historical_operation'] as int,
    images: (json['images'] as List)
            ?.map((e) =>
                e == null ? null : ImageDB.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    patient: json['patient'] as int,
  );
}

Map<String, dynamic> _$PrescriptionToJson(Prescription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'drug': instance.drug,
      'dose': instance.dose,
      'frequency': instance.frequency,
      'prescription_start_date': instance.prescriptionStartDate,
      'prescription_end_date': instance.prescriptionEndDate,
      'prescribing_doctor': instance.prescribingDoctor,
      'historical_condition': instance.historicalCondition,
      'historical_operation': instance.historicalOperation,
      'images': instance.images,
      'patient': instance.patient,
    };
