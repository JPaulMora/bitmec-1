// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Habit _$HabitFromJson(Map<String, dynamic> json) {
  return Habit(
    id: json['id'] as int,
    habit: json['habit'] as String,
    habitStartDate: json['habit_start_date'] as String,
    habitEndDate: json['habit_end_date'] as String,
    quantity: json['quantity'] as String,
    frequency: json['frequency'] as String,
    intakeMethod: json['intake_method'] as String,
  );
}

Map<String, dynamic> _$HabitToJson(Habit instance) => <String, dynamic>{
      'id': instance.id,
      'habit': instance.habit,
      'habit_start_date': instance.habitStartDate,
      'habit_end_date': instance.habitEndDate,
      'quantity': instance.quantity,
      'frequency': instance.frequency,
      'intake_method': instance.intakeMethod,
    };
