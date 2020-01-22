// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reproductive_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReproductiveHistory _$ReproductiveHistoryFromJson(Map<String, dynamic> json) {
  return ReproductiveHistory(
    id: json['id'] as int,
    firstMenstruationDate: json['first_menstruation_first'] as String,
    lastMenstruationDate: json['last_menstruation_date'] as String,
    pregnancies: json['pregnancies'] as int,
    liveBirths: json['live_births'] as int,
    stillborns: json['stillborns'] as int,
    abortions: json['abortions'] as int,
  );
}

Map<String, dynamic> _$ReproductiveHistoryToJson(
        ReproductiveHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_menstruation_first': instance.firstMenstruationDate,
      'last_menstruation_date': instance.lastMenstruationDate,
      'pregnancies': instance.pregnancies,
      'live_births': instance.liveBirths,
      'stillborns': instance.stillborns,
      'abortions': instance.abortions,
    };
