import 'package:json_annotation/json_annotation.dart';

import 'entity.dart';

part 'patient.g.dart';

@JsonSerializable(explicitToJson: true)
class Patient {
  int id;
  @JsonKey(name: 'first_name') String firstName;
  @JsonKey(name: 'last_name') String lastName;
  @JsonKey(name: 'birth_date') String birthDate;
  bool gender;
  @JsonKey(name: 'government_id') String governmentId;
  @JsonKey(name: 'profile_picture') String profilePicture;
  @JsonKey(name: 'phone_number') String phoneNumber;
  String country;
  String state;
  String city;
  String address;
  bool alive;
  bool active;
  Entity entity;

  Patient({
    this.id,
    this.firstName,
    this.lastName,
    this.birthDate,
    this.gender,
    this.governmentId,
    this.profilePicture,
    this.phoneNumber,
    this.country,
    this.state,
    this.city,
    this.address,
    this.alive,
    this.active,
    this.entity,
  });

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);

  Map<String, dynamic> toJson() => _$PatientToJson(this);

  String get fullName => '$firstName\n$lastName';

  int get yearsOld {
    final now = DateTime.now();
    final date = DateTime.parse(birthDate);

    int age = now.year - date.year;
    int m1 = now.month, m2 = date.month;

    if (m2 > m1) {
      age --;
    } else if (m2 == m1) {
      int d1 = now.day, d2 = date.day;

      if (d2 > d1) {
        age --;
      }
    }

    return age;
  }
}
