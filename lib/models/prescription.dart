import 'package:json_annotation/json_annotation.dart';

import 'package:bitmec/models.dart';

part 'prescription.g.dart';

@JsonSerializable()
class Prescription {
  int id;
  String drug;
  String dose;
  String frequency;
  @JsonKey(name: 'prescription_start_date') String prescriptionStartDate;
  @JsonKey(name: 'prescription_end_date') String prescriptionEndDate;
  @JsonKey(name: 'prescribing_doctor') String prescribingDoctor;
  @JsonKey(name: 'historical_condition') int historicalCondition;
  @JsonKey(name: 'historical_operation') int historicalOperation;
  @JsonKey(defaultValue: []) List<ImageDB> images;
  int patient;

  Prescription({
    this.id,
    this.drug,
    this.dose,
    this.frequency,
    this.prescriptionStartDate,
    this.prescriptionEndDate,
    this.prescribingDoctor,
    this.historicalCondition,
    this.historicalOperation,
    this.images,
    this.patient,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionToJson(this);

  formattedDescription() => '$dose cada $frequency';

  formattedDate() => 'Desde $prescriptionStartDate a ${prescriptionEndDate ?? ''}';
}
