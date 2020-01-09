import 'package:flutter/material.dart';

import 'package:bitmec/screens.dart';

import '../list_of_section.dart';

class PatientDetailFamilyHistoryView extends StatefulWidget {
  @override
  _PatientDetailFamilyHistoryViewState createState() =>
      _PatientDetailFamilyHistoryViewState();
}

class _PatientDetailFamilyHistoryViewState
    extends State<PatientDetailFamilyHistoryView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListOfSection(
        title: 'Familia',
        onPressedAdd: () {
          Navigator.pushNamed(context,
              PatientDetailFamilyHistoryCreateScreen.routeName);
        },
        children: <Widget>[
          _FamilyCard(),
          _FamilyCard(),
          _FamilyCard(),
        ],
      ),
    );
  }
}

class _FamilyCard extends StatelessWidget {
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
                Text('Tipo De Parentesco', style: TextStyle(fontSize: 24.0)),
                Padding(padding: const EdgeInsets.symmetric(vertical: 5.0)),
                Text('condición'),
                Text('Descripción de la condición', style: TextStyle(
                  fontWeight: FontWeight.bold
                )),
              ],
            ),

            Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Text('Fecha De Diagnostico', style: TextStyle(
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
