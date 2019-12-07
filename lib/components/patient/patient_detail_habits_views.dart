import 'package:flutter/material.dart';

import '../list_of_section.dart';

class PatientDetailHabitsView extends StatefulWidget {
  @override
  _PatientDetailHabitsViewState createState() =>
      _PatientDetailHabitsViewState();
}

class _PatientDetailHabitsViewState
    extends State<PatientDetailHabitsView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListOfSection(
        title: 'Hábitos',
        children: <Widget>[
          _HabitCard(),
          _HabitCard(),
          _HabitCard(),
        ],
      ),
    );
  }
}

class _HabitCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Tipo De Hábito', style: TextStyle(fontSize: 24.0)),
                Padding(padding: const EdgeInsets.symmetric(vertical: 5.0)),
                Text('¿Lo practica actualmente?'),
              ],
            ),

            Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Text('No', style: TextStyle(
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
