import 'package:flutter/material.dart';

import 'package:bitmec/screens/screens.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: _buildItems(context),
      ),
    );
  }

  List<Widget> _buildItems(BuildContext context) {
    return <Widget>[
      // Appointments
      ListTile(
        title: Text('Citas'),
        onTap: () {
          Navigator.pushNamed(context, HomeScreen.routeName);
        },
      ),

      // Patients
      ListTile(
        title: Text('Pacientes'),
        onTap: () {
          Navigator.pushNamed(context, PatientListScreen.routeName);
        },
      ),
    ];
  }
}
