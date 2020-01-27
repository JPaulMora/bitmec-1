// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    id: json['id'] as int,
    message: json['message'] as String,
    timestamp: json['timestamp'] as String,
    doctor: json['doctor'] == null ? null : Doctor.fromJson(json['doctor']),
    ambassador: json['ambassador'] == null
        ? null
        : Ambassador.fromJson(json['ambassador']),
    consultation: json['consultation'] == null
        ? null
        : Consultation.fromJson(json['consultation']),
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'timestamp': instance.timestamp,
      'doctor': instance.doctor,
      'ambassador': instance.ambassador,
      'consultation': instance.consultation,
    };
