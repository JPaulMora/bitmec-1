import 'package:json_annotation/json_annotation.dart';

part 'consultation.g.dart';

@JsonSerializable()
class Consultation {
  int id;
  String name;
  int patient;
  bool active;
  String timestamp;

  Consultation({
    this.id,
    this.name,
    this.patient,
    this.active,
    this.timestamp,
  });

  factory Consultation.fromJson(Map<String, dynamic> json) =>
      _$ConsultationFromJson(json);

  Map<String, dynamic> toJson() => _$ConsultationToJson(this);

  String formattedDate() {
    final date = DateTime.parse(timestamp);
    return '${date.day}/${date.month}/${date.year}';
  }
}
