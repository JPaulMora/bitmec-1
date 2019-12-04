import 'package:flutter/material.dart';

import 'appointment_card.dart';

class AppointmentListView extends StatefulWidget {
  final String title;
  final Color color;

  AppointmentListView({
    Key key,
    @required this.title,
    this.color = Colors.grey,
  }) : super(key: key);

  @override
  _AppointmentListViewState createState() => _AppointmentListViewState();
}

class _AppointmentListViewState extends State<AppointmentListView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.title, style: TextStyle(
            color: widget.color,
            fontSize: 50.0,
          )),

          AppointmentCard(),
          AppointmentCard(),
          AppointmentCard(),
          AppointmentCard(),
          AppointmentCard(),
        ],
      ),
    );
  }
}
