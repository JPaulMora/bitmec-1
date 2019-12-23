import 'package:bitmec/screens/screens.dart';

class MyRoutes {
  static String initialRoute() {
    return LoginScreen.routeName;
  }

  static final routes = {
    HomeScreen.routeName: (context) => HomeScreen(),
    LoginScreen.routeName: (context) => LoginScreen(),
    ChatScreen.routeName: (context) => ChatScreen(),

    // Patient Routes
    PatientListScreen.routeName: (context) => PatientListScreen(),
    PatientEditScreen.routeName: (context) => PatientEditScreen(),
    PatientCreateScreen.routeName: (context) => PatientCreateScreen(),

    PatientDetailScreen.routeName: (context) => PatientDetailScreen(),
    PatientDetailMedicalConditionCreateScreen.routeName: (context) =>
        PatientDetailMedicalConditionCreateScreen(),
    PatientDetailMedicalTraumaCreateScreen.routeName: (context) =>
        PatientDetailMedicalTraumaCreateScreen(),
    PatientDetailFamilyHistoryCreateScreen.routeName: (context) =>
      PatientDetailFamilyHistoryCreateScreen(),
    PatientDetailHabitCreateScreen.routeName: (context) =>
      PatientDetailHabitCreateScreen(),
    PatientDetailDependentCreateScreen.routeName: (context) =>
        PatientDetailDependentCreateScreen(),

    // Appointment Routes
    AppointmentDetailScreen.routeName: (context) => AppointmentDetailScreen(),

    // Vital Sign Routes
    VitalSignCreateScreen.routeName: (context) => VitalSignCreateScreen(),
  };
}
