import 'package:flutter/material.dart';

import 'package:bitmec/screens/patient/patient_create_screen.dart';

import 'package:bitmec/providers.dart';

import 'package:bitmec/components/my_drawer.dart';
import 'package:bitmec/components/my_app_bar.dart';
import 'package:bitmec/components/patient/patient_components.dart';

class PatientListScreen extends StatefulWidget {
  static const routeName = '/patient/list';

  @override
  _PatientListScreenState createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  PatientProvider _provider;

  @override
  Widget build(BuildContext context) {
    if (_provider == null) {
      setState(() {
        _provider = PatientProvider.of(context);

        if (_provider.dataLoaded == false) {
          _provider.fetchAll();
        }
      });
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      drawer: MyDrawer(),
      body: SafeArea(
        child: _buildBody(context),
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

  Widget _buildBody(BuildContext context) {
    if (_provider.dataLoaded == false) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_provider.data.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.person, size: 100.0),

            Text('Sin Registros Disponibles', style: TextStyle(
                fontSize: 25.0
            )),

            Text('Intenta recarga esta pantalla nuevamente'),
          ],
        ),
      );
    }

    return _buildBodyList(context);
  }

  Widget _buildBodyList(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: _provider.data.length,
        itemBuilder: (context, index) => PatientCard(
          patient: _provider.data[index],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10.0,
        ),
      ),
    );
  }
}
