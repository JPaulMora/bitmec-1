import 'package:flutter/material.dart';

import 'package:bitmec/components/my_app_bar.dart';
import 'package:bitmec/components/quick_actions_components.dart';
import 'package:bitmec/components/list_of_section.dart';

import '../vital_sign/vital_sign_create_screen.dart';

class AppointmentDetailScreen extends StatefulWidget {
  static const routeName = '/appointment/detail';

  @override
  _AppointmentDetailScreenState createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return MyAppBar(
      title: 'Detalle',
      scaffoldKey: _scaffoldKey,
      backLeading: true,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildQuickActionsSection(context),
          _buildVitalSignsSection(context),
          _buildSymptomsSection(context),
          _buildLaboratoryOrdersSection(context),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection(BuildContext context) {
    return QuickActionsSection(
      children: <QuickActionIcon>[
        QuickActionIcon(
          icon: Icon(Icons.fiber_manual_record),
          color: Colors.red,
          label: 'Signos Vitales',
          onTap: () {
            Navigator.pushNamed(context, VitalSignCreateScreen.routeName);
          },
        ),

        QuickActionIcon(
          icon: Icon(Icons.assignment_ind),
          color: Colors.purple,
          label: 'Sintomas',
          onTap: () {},
        ),

        QuickActionIcon(
          icon: Icon(Icons.chat),
          color: Colors.green,
          label: 'Chat',
          onTap: () {},
        ),

        QuickActionIcon(
          icon: Icon(Icons.dock),
          color: Colors.lightBlueAccent,
          label: 'Consulta',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildVitalSignsSection(BuildContext context) {
    return ListOfSection(
      title: 'Signos Vitales',
      children: <Widget>[],
    );
  }

  Widget _buildSymptomsSection(BuildContext context) {
    return ListOfSection(
      title: 'Sintomas',
      children: <Widget>[],
    );
  }

  Widget _buildLaboratoryOrdersSection(BuildContext context) {
    return ListOfSection(
      title: 'Órdenes de Laboratorio',
      children: <Widget>[],
    );
  }
}
