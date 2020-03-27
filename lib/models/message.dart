import 'package:json_annotation/json_annotation.dart';

import 'package:bitmec/models.dart';

part 'message.g.dart';

int _doctorToJson(Doctor doctor) => doctor?.id ?? null;
Doctor _doctorFromJson(doctor) {
  if (doctor is int) return Doctor(id: doctor);
  if (doctor is Map) return Doctor.fromJson(doctor);
  return null;
}

int _ambassadorToJson(Ambassador ambassador) => ambassador.id;
Ambassador _ambassadorFromJson(ambassador) {
  if (ambassador is int) return Ambassador(id: ambassador);
  if (ambassador is Map) return Ambassador.fromJson(ambassador);
  return Ambassador();
}

int _consultationFromJson(consultation) {
  if (consultation is int) return consultation;
  if (consultation is Map) return Consultation.fromJson(consultation).id;
  return null;
}

@JsonSerializable()
class Message {
  int id;
  String message;
  String timestamp;
  @JsonKey(toJson: _doctorToJson, fromJson: _doctorFromJson) Doctor doctor;
  @JsonKey(toJson: _ambassadorToJson, fromJson: _ambassadorFromJson)
  Ambassador ambassador;
  @JsonKey(fromJson: _consultationFromJson) int consultation;

  Message({
    this.id,
    this.message,
    this.timestamp,
    this.doctor,
    this.ambassador,
    this.consultation,
  });

  factory Message.fromJson(Map json) => _$MessageFromJson(json);

  Map toJson() => _$MessageToJson(this);
}
