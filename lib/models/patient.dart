import 'package:bitmec/components.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:bitmec/models.dart';

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
  List<Consultation> consultations;
  @JsonKey(name: 'historical_conditions') List<MedicalCondition> historicalConditions;
  @JsonKey(name: 'historical_operations') List<Surgery> historicalOperations;
  @JsonKey(name: 'historical_prescriptions') List<Prescription> historicalPrescriptions;
  @JsonKey(name: 'reproductive_history') List<ReproductiveHistory> reproductiveHistory;
  @JsonKey(name: 'birth_control') List<BirthControl> birthControls;
  @JsonKey(name: 'family_member_conditions') List<FamilyMemberCondition> familyMembers;
  List<Habit> habits;

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
    this.consultations,
    this.historicalConditions,
    this.historicalOperations,
    this.historicalPrescriptions,
    this.reproductiveHistory,
    this.birthControls,
    this.familyMembers,
    this.habits,
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
