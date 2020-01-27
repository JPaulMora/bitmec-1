// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) {
  return Appointment(
    id: json['id'] as int,
    appointmentType: json['appointment_type'] as String,
    scheduled: json['scheduled'] as String,
    start: json['start'] as String,
    end: json['end'] as String,
    patient: _patientFromJson(json['patient']),
    consultation: _consultationFromJson(json['consultation']),
    ambassador: json['ambassador'] == null
        ? null
        : Ambassador.fromJson(json['ambassador']),
    doctor: json['doctor'] == null ? null : Doctor.fromJson(json['doctor']),
  );
}

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appointment_type': instance.appointmentType,
      'scheduled': instance.scheduled,
      'start': instance.start,
      'end': instance.end,
      'patient': _patientToJson(instance.patient),
      'consultation': _consultationToJson(instance.consultation),
      'ambassador': instance.ambassador?.toJson(),
      'doctor': instance.doctor?.toJson(),
    };
