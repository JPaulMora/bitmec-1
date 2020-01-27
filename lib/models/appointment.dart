import 'package:json_annotation/json_annotation.dart';

import 'package:bitmec/models.dart';

part 'appointment.g.dart';

@JsonSerializable(explicitToJson: true)
class Appointment {
  int id;
  @JsonKey(name: 'appointment_type') String appointmentType;
  String scheduled;
  String start;
  String end;
  Patient patient;
  Consultation consultation;
  Ambassador ambassador;
  Doctor doctor;

  Appointment({
    this.id,
    this.appointmentType,
    this.scheduled,
    this.start,
    this.end,
    this.patient,
    this.consultation,
    this.ambassador,
    this.doctor,
  });

  factory Appointment.fromJson(json) => _$AppointmentFromJson(json);

  Map toJson() => _$AppointmentToJson(this);
}
