// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'birth_control.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BirthControl _$BirthControlFromJson(Map<String, dynamic> json) {
  return BirthControl(
    id: json['id'] as int,
    method: json['method'] as String,
    methodStartDate: json['method_start_date'] as String,
    methodEndDate: json['method_end_date'] as String,
    prescribingDoctor: json['prescribing_doctor'] as String,
    patient: json['patient'] as int,
  );
}

Map<String, dynamic> _$BirthControlToJson(BirthControl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'method': instance.method,
      'method_start_date': instance.methodStartDate,
      'method_end_date': instance.methodEndDate,
      'prescribing_doctor': instance.prescribingDoctor,
      'patient': instance.patient,
    };
