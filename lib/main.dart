import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:bitmec/providers.dart';

import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MultiProvider(
    child: MyApp(),
    providers: [
      ChangeNotifierProvider(create: (context) => PatientProvider()),
      ChangeNotifierProvider(create: (context) => AppointmentProvider()),
      ChangeNotifierProvider(create: (context) => ConsultationProvider()),
      ChangeNotifierProvider(create: (context) => VitalSignProvider()),
      ChangeNotifierProvider(create: (context) => SymptomProvider()),
      ChangeNotifierProvider(create: (context) => ImageDBProvider()),
      ChangeNotifierProvider(create: (context) => MedicalConditionProvider()),
      ChangeNotifierProvider(create: (context) => MedicalSurgeryProvider()),
      ChangeNotifierProvider(create: (context) => MedicalPrescriptionProvider()),
      ChangeNotifierProvider(create: (context) => ReproductiveHistoryProvider()),
      ChangeNotifierProvider(create: (context) => BirthControlProvider()),
      ChangeNotifierProvider(create: (context) => FamilyHistoryProvider()),
      ChangeNotifierProvider(create: (context) => HabitProvider()),
    ],
  ));
}
