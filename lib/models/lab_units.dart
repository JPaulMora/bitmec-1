import 'package:json_annotation/json_annotation.dart';

part 'lab_units.g.dart';

@JsonSerializable()
class LabUnits {
  int id;
  String name;

  LabUnits({
    this.id,
    this.name,
  });

  factory LabUnits.fromJson(json) => _$LabUnitsFromJson(json);

  Map toJson() => _$LabUnitsToJson(this);
}
