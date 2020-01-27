import 'package:bitmec/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'consultation.g.dart';

int _patientFromJson(json) {
  if (json is Map<String, dynamic>) {
    return Patient.fromJson(json).id;
  }

  return json;
}

@JsonSerializable(explicitToJson: true)
class Consultation {
  int id;
  String name;
  @JsonKey(fromJson: _patientFromJson) int patient;
  bool active;
  String timestamp;
  @JsonKey(name: 'vital_signs') List<VitalSign> vitalSigns;
  List<Symptom> symptoms;
  @JsonKey(name: 'lab_orders') List<LaboratoryOrder> labOrders;

  Consultation({
    this.id,
    this.name,
    this.patient,
    this.active,
    this.timestamp,
    this.vitalSigns,
    this.symptoms,
    this.labOrders,
  });

  factory Consultation.fromJson(json) => _$ConsultationFromJson(json);

  Map toJson() => _$ConsultationToJson(this);

  String formattedDate() {
    final date = DateTime.parse(timestamp);
    return '${date.day}/${date.month}/${date.year}';
  }
}
