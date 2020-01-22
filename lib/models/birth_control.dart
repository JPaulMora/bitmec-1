import 'package:json_annotation/json_annotation.dart';

part 'birth_control.g.dart';

@JsonSerializable()
class BirthControl {
  int id;
  String method;
  @JsonKey(name: 'method_start_date') String methodStartDate;
  @JsonKey(name: 'method_end_date') String methodEndDate;
  @JsonKey(name: 'prescribing_doctor') String prescribingDoctor;

  BirthControl({
    this.id,
    this.methodStartDate,
    this.methodEndDate,
    this.prescribingDoctor,
  });

  factory BirthControl.fromJson(json) => _$BirthControlFromJson(json);

  Map toJson() => _$BirthControlToJson(this);

  String formattedStartDate() {
    final date = DateTime.parse(methodStartDate);
    return '${date.day}/${date.month}/${date.year}';
  }

  String formattedEndDate() {
    final date = DateTime.parse(methodEndDate);
    return '${date.day}/${date.month}/${date.year}';
  }
}
