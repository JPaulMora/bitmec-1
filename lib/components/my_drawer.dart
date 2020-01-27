import 'package:flutter/material.dart';

import 'package:bitmec/screens.dart';
import 'package:bitmec/providers.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  PatientProvider _patientProvider;
  AppointmentProvider _appointmentProvider;

  @override
  Widget build(BuildContext context) {
    if (_patientProvider == null) {
      setState(() {
        _patientProvider = PatientProvider.of(context);
      });
    }

    if (_appointmentProvider == null) {
      setState(() {
        _appointmentProvider = AppointmentProvider.of(context);
      });
    }

    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Center(
              child: Text('Bitmec', style: TextStyle(
                fontSize: 100.0,
                color: Colors.blue,
              )),
            ),

            Divider(height: 10.0, color: Colors.grey),

            ListTile(
              leading: Icon(Icons.note),
              title: Text('Citas'),
              onTap: () {
                Navigator.popAndPushNamed(context, HomeScreen.routeName);
              },
            ),

            ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('Pacientes'),
              onTap: () {
                Navigator.popAndPushNamed(context, PatientListScreen.routeName);
              },
            ),

            Divider(height: 10.0, color: Colors.grey),

            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text('Cerrar Sesión', style: TextStyle(color: Colors.red)),
              onTap: () {
                _patientProvider.removeData();
                _appointmentProvider.removeData();
                Navigator.popAndPushNamed(context, LoginScreen.routeName);
              },
            )
          ],
        ),
      ),
    );
  }
}
