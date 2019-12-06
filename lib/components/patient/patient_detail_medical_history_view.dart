import 'package:flutter/material.dart';

import '../list_of_section.dart';

class PatientDetailMedicalHistoryView extends StatefulWidget {
  @override
  _PatientDetailMedicalHistoryViewState createState() =>
      _PatientDetailMedicalHistoryViewState();
}

class _PatientDetailMedicalHistoryViewState
    extends State<PatientDetailMedicalHistoryView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _MedicalConditionsSection(),
          _MedicalSurgeriesSection(),
        ],
      ),
    );
  }
}

class _MedicalConditionsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListOfSection(
      title: 'Padecimientos',
      children: <Widget>[
        _MedicalConditionCard(),
        _MedicalConditionCard(),
      ],
    );
  }
}

class _MedicalConditionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Padecimiento', style: TextStyle(fontSize: 24.0)),
                Padding(padding: const EdgeInsets.symmetric(vertical: 5.0)),
                Text('Diagnosticado port:'),
                Text('Dr. Jose Pérez', style: TextStyle(
                  fontWeight: FontWeight.bold
                )),
              ],
            ),

            Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Text('Fecha : Hora', style: TextStyle(
                  color: Colors.blueAccent,
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MedicalSurgeriesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListOfSection(
      title: 'Cirugias',
      children: <Widget>[
        _MedicalSurgeryCard(),
      ],
    );
  }
}

class _MedicalSurgeryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Cirugía', style: TextStyle(fontSize: 24.0)),
                Padding(padding: const EdgeInsets.symmetric(vertical: 5.0)),
                Text('Realizada por:'),
                Text('Dr. Jose Pérez', style: TextStyle(
                    fontWeight: FontWeight.bold
                )),
              ],
            ),

            Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Text('Fecha : Hora', style: TextStyle(
                  color: Colors.blueAccent,
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
