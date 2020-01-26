import 'package:json_annotation/json_annotation.dart';

part 'reproductive_history.g.dart';

@JsonSerializable()
class ReproductiveHistory {
  int id;
  @JsonKey(name: 'first_menstruation_first') String firstMenstruationDate;
  @JsonKey(name: 'last_menstruation_date') String lastMenstruationDate;
  int pregnancies;
  @JsonKey(name: 'live_births') int liveBirths;
  int stillborns;
  int abortions;
  int patient;

  ReproductiveHistory({
    this.id,
    this.firstMenstruationDate,
    this.lastMenstruationDate,
    this.pregnancies,
    this.liveBirths,
    this.stillborns,
    this.abortions,
    this.patient,
  });

  factory ReproductiveHistory.fromJson(Map<String, dynamic> json) =>
      _$ReproductiveHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$ReproductiveHistoryToJson(this);

  String formattedFirstMenstruationDate() {
    final date = DateTime.parse(firstMenstruationDate);
    return '${date.day}/${date.month}/${date.year}';
  }

  String formattedLastMenstruationDate() {
    final date = DateTime.parse(lastMenstruationDate);
    return '${date.day}/${date.month}/${date.year}';
  }
}
