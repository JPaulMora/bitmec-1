import 'package:json_annotation/json_annotation.dart';

import 'package:bitmec/models.dart';

part 'laboratory_order.g.dart';

@JsonSerializable(explicitToJson: true)
class LaboratoryOrder {
  int id;
  Doctor doctor;
  @JsonKey(name: 'lab_format') LabFormat labFormat;
  String timestamp;
  List<LabResult> results;

  LaboratoryOrder({
    this.id,
    this.doctor,
    this.labFormat,
    this.timestamp,
    this.results,
  });

  factory LaboratoryOrder.fromJson(json) => _$LaboratoryOrderFromJson(json);

  Map toJson() => _$LaboratoryOrderToJson(this);
}
