import 'package:flutter/material.dart';

import 'package:bitmec/components/my_drawer.dart';
import 'package:bitmec/components/my_app_bar.dart';
import 'package:bitmec/components/patient/patient_components.dart';

import 'package:bitmec/screens/patient/patient_create_screen.dart';

class PatientListScreen extends StatefulWidget {
  static const routeName = '/patient/list';

  @override
  _PatientListScreenState createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: _buildAppBar(context),
        drawer: _buildAppDrawer(context),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return MyAppBar(
      title: 'Pacientes',
      scaffoldKey: _scaffoldKey,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          tooltip: 'Agregar Paciente',
          onPressed: () {
            Navigator.pushNamed(context, PatientCreateScreen.routeName);
          },
        )
      ],
    );
  }

  Widget _buildAppDrawer(BuildContext context) {
    return MyDrawer();
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: PatientListView(),
    );
  }
}
