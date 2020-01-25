import 'package:json_annotation/json_annotation.dart';

import 'package:bitmec/models.dart';

part 'surgery.g.dart';

@JsonSerializable()
class Surgery {
  int id;
  String operation;
  @JsonKey(name: 'historical_condition') int historicalCondition;
  @JsonKey(name: 'operation_date') String operationDate;
  @JsonKey(name: 'operating_doctor') String operatingDoctor;
  @JsonKey(defaultValue: []) List<ImageDB> images;
  int patient;

  Surgery({
    this.id,
    this.operation,
    this.historicalCondition,
    this.operationDate,
    this.operatingDoctor,
    this.images,
    this.patient,
  });

  factory Surgery.fromJson(Map<String, dynamic> json) =>
      _$SurgeryFromJson(json);

  Map<String, dynamic> toJson() => _$SurgeryToJson(this);
}
