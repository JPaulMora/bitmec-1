import 'package:intl/intl.dart';

import 'package:json_annotation/json_annotation.dart';

part 'birth_control.g.dart';

@JsonSerializable()
class BirthControl {
  int id;
  String method;
  @JsonKey(name: 'method_start_date') String methodStartDate;
  @JsonKey(name: 'method_end_date') String methodEndDate;
  @JsonKey(name: 'prescribing_doctor') String prescribingDoctor;
  int patient;

  BirthControl({
    this.id,
    this.method,
    this.methodStartDate,
    this.methodEndDate,
    this.prescribingDoctor,
    this.patient,
  });

  factory BirthControl.fromJson(json) => _$BirthControlFromJson(json);

  Map toJson() => _$BirthControlToJson(this);

  String _formatDate(dStr) {
    if (dStr == null) return 'sin fecha';
    final date = DateTime.parse(dStr);
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String formattedDate() =>
      'Desde ${_formatDate(methodStartDate)} hasta ${_formatDate(methodEndDate)}';
}
