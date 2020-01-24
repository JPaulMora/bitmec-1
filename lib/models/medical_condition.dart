import 'package:json_annotation/json_annotation.dart';

import 'package:bitmec/models.dart';

part 'medical_condition.g.dart';

@JsonSerializable()
class MedicalCondition {
  int id;
  String condition;
  @JsonKey(name: 'diagnosis_date') String diagnosisDate;
  @JsonKey(name: 'diagnosing_doctor') String diagnosingDoctor;
  @JsonKey(defaultValue: []) List<Image> images;
  int patient;

  MedicalCondition({
    this.id,
    this.condition,
    this.diagnosisDate,
    this.diagnosingDoctor,
    this.patient,
  });

  factory MedicalCondition.fromJson(Map<String, dynamic> json) =>
      _$MedicalConditionFromJson(json);

  Map<String, dynamic> toJson() => _$MedicalConditionToJson(this);
}
