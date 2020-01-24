// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) {
  return Patient(
    id: json['id'] as int,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    birthDate: json['birth_date'] as String,
    gender: json['gender'] as bool,
    governmentId: json['government_id'] as String,
    profilePicture: json['profile_picture'] as String,
    phoneNumber: json['phone_number'] as String,
    country: json['country'] as String,
    state: json['state'] as String,
    city: json['city'] as String,
    address: json['address'] as String,
    alive: json['alive'] as bool,
    active: json['active'] as bool,
    entity: json['entity'] == null
        ? null
        : Entity.fromJson(json['entity'] as Map<String, dynamic>),
    consultations: (json['consultations'] as List)
        ?.map((e) => e == null ? null : Consultation.fromJson(e))
        ?.toList(),
    historicalConditions: (json['historical_conditions'] as List)
        ?.map((e) => e == null
            ? null
            : MedicalCondition.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    historicalOperations: (json['historical_operations'] as List)
        ?.map((e) =>
            e == null ? null : Surgery.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    historicalPrescriptions: (json['historical_prescriptions'] as List)
        ?.map((e) =>
            e == null ? null : Prescription.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    reproductiveHistory: (json['reproductive_history'] as List)
        ?.map((e) => e == null
            ? null
            : ReproductiveHistory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    birthControls: (json['birth_control'] as List)
        ?.map((e) => e == null ? null : BirthControl.fromJson(e))
        ?.toList(),
    familyMembers: (json['family_member_conditions'] as List)
        ?.map((e) => e == null ? null : FamilyMemberCondition.fromJson(e))
        ?.toList(),
    habits: (json['habits'] as List)
        ?.map(
            (e) => e == null ? null : Habit.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'birth_date': instance.birthDate,
      'gender': instance.gender,
      'government_id': instance.governmentId,
      'profile_picture': instance.profilePicture,
      'phone_number': instance.phoneNumber,
      'country': instance.country,
      'state': instance.state,
      'city': instance.city,
      'address': instance.address,
      'alive': instance.alive,
      'active': instance.active,
      'entity': instance.entity?.toJson(),
      'consultations':
          instance.consultations?.map((e) => e?.toJson())?.toList(),
      'historical_conditions':
          instance.historicalConditions?.map((e) => e?.toJson())?.toList(),
      'historical_operations':
          instance.historicalOperations?.map((e) => e?.toJson())?.toList(),
      'historical_prescriptions':
          instance.historicalPrescriptions?.map((e) => e?.toJson())?.toList(),
      'reproductive_history':
          instance.reproductiveHistory?.map((e) => e?.toJson())?.toList(),
      'birth_control':
          instance.birthControls?.map((e) => e?.toJson())?.toList(),
      'family_member_conditions':
          instance.familyMembers?.map((e) => e?.toJson())?.toList(),
      'habits': instance.habits?.map((e) => e?.toJson())?.toList(),
    };
