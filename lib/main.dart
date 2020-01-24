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
    providers: [
      ChangeNotifierProvider(create: (context) => PatientProvider()),
      ChangeNotifierProvider(create: (context) => ConsultationProvider()),
      ChangeNotifierProvider(create: (context) => VitalSignProvider()),
    ],
    child: MyApp(),
  ));
}
