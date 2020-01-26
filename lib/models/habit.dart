import 'package:json_annotation/json_annotation.dart';

part 'habit.g.dart';

@JsonSerializable()
class Habit {
  int id;
  String habit;
  @JsonKey(name: 'habit_start_date') String habitStartDate;
  @JsonKey(name: 'habit_end_date') String habitEndDate;
  String quantity;
  String frequency;
  @JsonKey(name: 'intake_methods') String intakeMethods;
  int patient;

  Habit({
    this.id,
    this.habit,
    this.habitStartDate,
    this.habitEndDate,
    this.quantity,
    this.frequency,
    this.intakeMethods,
    this.patient,
  });

  factory Habit.fromJson(Map<String, dynamic> json) =>
      _$HabitFromJson(json);

  Map toJson() => _$HabitToJson(this);

  bool practiceCurrently() {
    if (habitEndDate == null) {
      return true;
    }

    final date = DateTime.parse(habitEndDate);
    final now = DateTime.now();
    return !(now.compareTo(date) >= 0);
  }
}
