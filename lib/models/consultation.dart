import 'package:bitmec/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'consultation.g.dart';

@JsonSerializable(explicitToJson: true)
class Consultation {
  int id;
  String name;
  int patient;
  bool active;
  String timestamp;
  @JsonKey(name: 'vital_signs') List<VitalSign> vitalSigns;

  Consultation({
    this.id,
    this.name,
    this.patient,
    this.active,
    this.timestamp,
  });

  factory Consultation.fromJson(json) => _$ConsultationFromJson(json);

  Map toJson() => _$ConsultationToJson(this);

  String formattedDate() {
    final date = DateTime.parse(timestamp);
    return '${date.day}/${date.month}/${date.year}';
  }
}
