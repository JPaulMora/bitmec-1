import 'package:json_annotation/json_annotation.dart';

part 'vital_sign.g.dart';

@JsonSerializable()
class VitalSign {
  int id;
  double weight;
  double height;
  @JsonKey(name: 'systolic_pressure') double systolicPressure;
  @JsonKey(name: 'diastolic_pressure') double diastolicPressure;
  @JsonKey(name: 'heart_rate') double heartRate;
  double temperature;
  double glucose;
  double oxygen;
  String timestamp;

  // To Post
  int consultation;

  VitalSign({
    this.id,
    this.weight,
    this.height,
    this.systolicPressure,
    this.diastolicPressure,
    this.heartRate,
    this.temperature,
    this.glucose,
    this.oxygen,
    this.timestamp,
    this.consultation,
  });

  factory VitalSign.fromJson(Map json) => _$VitalSignFromJson(json);

  Map toJson() => _$VitalSignToJson(this);
}
