import 'package:json_annotation/json_annotation.dart';

import 'package:bitmec/models.dart';

part 'lab_result.g.dart';

@JsonSerializable(explicitToJson: true)
class LabResult {
  int id;
  int measurement;
  LabUnits units;
  String timestamp;

  LabResult({
    this.id,
    this.measurement,
    this.units,
    this.timestamp,
  });

  factory LabResult.fromJson(json) => _$LabResultFromJson(json);

  Map toJson() => _$LabResultToJson(this);
}
