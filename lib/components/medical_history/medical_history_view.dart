import 'package:flutter/material.dart';

import 'package:bitmec/components.dart';
import 'package:bitmec/providers.dart';

class MedicalHistoryView extends StatefulWidget {
  @override
  _MedicalHistoryViewState createState() =>
      _MedicalHistoryViewState();
}

class _MedicalHistoryViewState extends State<MedicalHistoryView> {
  PatientProvider _provider;

  @override
  Widget build(BuildContext context) {
    if (_provider == null) {
      setState(() {
        _provider = PatientProvider.of(context);
      });
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MedicalConditionsSection(
            conditions: _provider.object.historicalConditions,
          ),

          MedicalSurgeriesSection(
            surgeries: _provider.object.historicalOperations,
          ),

          MedicalPrescriptionSection(
            medicines: _provider.object.historicalPrescriptions,
          ),

          _provider.object.gender ? Container() :
            ReproductiveHistorySection(
              reproductiveHealth: _provider.object.reproductiveHistory.first
            ),

          _provider.object.gender ? Container() :
            ContraceptivesSection(
              birthControls: _provider.object.birthControls,
            ),
        ],
      ),
    );
  }
}
