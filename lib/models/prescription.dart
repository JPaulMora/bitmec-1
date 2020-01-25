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
  List<ImageDB> images;

  Prescription({
    this.id
  });

  factory Prescription.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionToJson(this);

  formattedDescription() => '$dose cada $frequency';

  formattedDate() => 'Desde $prescriptionStartDate a ${prescriptionEndDate ?? ''}';
}
