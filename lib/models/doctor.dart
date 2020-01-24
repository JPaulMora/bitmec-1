import 'package:json_annotation/json_annotation.dart';

part 'doctor.g.dart';

@JsonSerializable(explicitToJson: true)
class Doctor {
  int id;
  @JsonKey(name: 'first_name') String firstName;
  @JsonKey(name: 'last_name') String lastName;

  Doctor({
    this.id,
    this.firstName,
    this.lastName,
  });

  factory Doctor.fromJson(json) => _$DoctorFromJson(json);

  Map toJson() => _$DoctorToJson(this);
}
