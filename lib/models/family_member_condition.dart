import 'package:json_annotation/json_annotation.dart';

part 'family_member_condition.g.dart';

@JsonSerializable()
class FamilyMemberCondition {
  int id;
  String relative;
  String condition;
  @JsonKey(name: 'date_diagnosed') String dateDiagnosed;
  int patient;

  FamilyMemberCondition({
    this.id,
    this.relative,
    this.condition,
    this.dateDiagnosed,
    this.patient,
  });

  factory FamilyMemberCondition.fromJson(json) =>
      _$FamilyMemberConditionFromJson(json);

  Map toJson() => _$FamilyMemberConditionToJson(this);
}
