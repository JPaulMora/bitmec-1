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
    doctor: _doctorFromJson(json['doctor']),
    ambassador: _ambassadorFromJson(json['ambassador']),
    consultation: _consultationFromJson(json['consultation']),
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'timestamp': instance.timestamp,
      'doctor': _doctorToJson(instance.doctor),
      'ambassador': _ambassadorToJson(instance.ambassador),
      'consultation': instance.consultation,
    };
