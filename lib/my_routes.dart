import 'package:bitmec/screens.dart';

class MyRoutes {
  static String initialRoute() {
    return LoginScreen.routeName;
  }

  static final routes = {
    HomeScreen.routeName: (context) => HomeScreen(),
    LoginScreen.routeName: (context) => LoginScreen(),
    ChatScreen.routeName: (context) => ChatScreen(),
    ConferenceScreen.routeName: (context) => ConferenceScreen(),

    // Medical History Routes
    MedicalConditionCreateUpdateScreen.routeName: (context) =>
        MedicalConditionCreateUpdateScreen(),
    MedicalSurgeryCreateUpdateScreen.routeName: (context) =>
        MedicalSurgeryCreateUpdateScreen(),
    MedicalPrescriptionCreateUpdateScreen.routeName: (context) =>
        MedicalPrescriptionCreateUpdateScreen(),
    ReproductiveHistoryCreateUpdateScreen.routeName: (context) =>
        ReproductiveHistoryCreateUpdateScreen(),
    BirthControlCreateUpdateScreen.routeName: (context) =>
        BirthControlCreateUpdateScreen(),

    // Patient Routes
    PatientListScreen.routeName: (context) => PatientListScreen(),
    PatientEditScreen.routeName: (context) => PatientEditScreen(),
    PatientCreateScreen.routeName: (context) => PatientCreateScreen(),
    PatientDetailScreen.routeName: (context) => PatientDetailScreen(),

    PatientDetailMedicalTraumaCreateScreen.routeName: (context) =>
        PatientDetailMedicalTraumaCreateScreen(),
    FamilyHistoryCreateUpdateScreen.routeName: (context) =>
      FamilyHistoryCreateUpdateScreen(),
    HabitCreateUpdateScreen.routeName: (context) =>
      HabitCreateUpdateScreen(),
    PatientDetailDependentCreateScreen.routeName: (context) =>
        PatientDetailDependentCreateScreen(),

    // Appointment Routes
    ConsultationDetailScreen.routeName: (context) => ConsultationDetailScreen(),
    AppointmentListByPatientScreen.routeName: (context) =>
        AppointmentListByPatientScreen(),
    AppointmentCreateUpdateScreen.routeName: (context) =>
        AppointmentCreateUpdateScreen(),

    // Vital Sign Routes
    VitalSignCreateScreen.routeName: (context) => VitalSignCreateScreen(),

    // Symptom Routes
    SymptomCreateScreen.routeName: (context) => SymptomCreateScreen(),
  };
}
