import 'package:json_annotation/json_annotation.dart';

import 'package:bitmec/models.dart';

part 'lab_format.g.dart';

@JsonSerializable(explicitToJson: true)
class LabFormat {
  int id;
  String name;
  @JsonKey(name: 'low_measurement') double lowMeasurement;
  @JsonKey(name: 'high_measurement') double highMeasurement;
  LabUnits units;

  LabFormat({
    this.id,
    this.name,
    this.lowMeasurement,
    this.highMeasurement,
    this.units,
  });

  factory LabFormat.fromJson(json) => _$LabFormatFromJson(json);

  Map toJson() => _$LabFormatToJson(this);
}
