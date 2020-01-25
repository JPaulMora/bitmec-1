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
  List<ImageDB> images;

  Surgery({
    this.id,
    this.operation,
    this.historicalCondition,
    this.operationDate,
    this.operatingDoctor,
    this.images,
  });

  factory Surgery.fromJson(Map<String, dynamic> json) =>
      _$SurgeryFromJson(json);

  Map<String, dynamic> toJson() => _$SurgeryToJson(this);

  String formattedDate() {
    final date = DateTime.parse(operationDate);
    return '${date.day}/${date.month}/${date.year}';
  }
}
