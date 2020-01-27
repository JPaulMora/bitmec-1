import 'package:json_annotation/json_annotation.dart';

import 'package:bitmec/models.dart';

part 'appointment.g.dart';

Patient _patientFromJson(patient) {
  if (patient is Map) {
    return Patient.fromJson(patient);
  }

  return Patient();
}

int _patientToJson(Patient patient) {
  return patient.id;
}

Consultation _consultationFromJson(consulation) {
  if (consulation is Map) {
    return Consultation.fromJson(consulation);
  }

  return Consultation();
}

int _consultationToJson(Consultation consultation) {
  return consultation.id;
}

@JsonSerializable(explicitToJson: true)
class Appointment {
  int id;
  @JsonKey(name: 'appointment_type') String appointmentType;
  String scheduled;
  String start;
  String end;
  @JsonKey(fromJson: _patientFromJson, toJson: _patientToJson)
  Patient patient;
  @JsonKey(fromJson: _consultationFromJson, toJson: _consultationToJson)
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

  String formattedType() {
    switch (appointmentType) {
      case 'S':
        return 'Seguimiento';
      case 'E':
        return 'Emergencia';
      case 'PC':
        return 'Primer Consulta';

      default:
        return 'Tipo no identificado';
    }
  }
}
