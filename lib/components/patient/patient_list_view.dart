import 'package:flutter/material.dart';

import 'patient_card.dart';

class PatientListView extends StatefulWidget {
  final String title;
  final Color color;

  PatientListView({
    Key key,
    this.title,
    this.color = Colors.grey,
  }) : super(key: key);

  @override
  _PatientListViewState createState() => _PatientListViewState();
}

class _PatientListViewState extends State<PatientListView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.title != null
          ? Text(widget.title, style: TextStyle(
            color: widget.color,
            fontSize: 50.0,
          ))
          : Container(),

          PatientCard(),
          PatientCard(),
          PatientCard(),
          PatientCard(),
          PatientCard(),
        ],
      ),
    );
  }
}
