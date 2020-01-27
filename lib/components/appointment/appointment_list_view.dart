import 'package:flutter/material.dart';

import 'package:bitmec/components.dart';
import 'package:bitmec/models.dart';

class AppointmentListView extends StatefulWidget {
  final String title;
  final Color color;
  final List<Appointment> list;

  AppointmentListView({
    @required this.title,
    this.color = Colors.grey,
    this.list = const [],
  });

  @override
  _AppointmentListViewState createState() => _AppointmentListViewState();
}

class _AppointmentListViewState extends State<AppointmentListView> {
  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 10.0,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.title, style: TextStyle(
            color: widget.color,
            fontSize: 50.0,
          )),
        ]..addAll(_buildList(context)),
      ),
    );
  }

  List<Widget> _buildList(context) {
    if (widget.list.isEmpty) {
      return [Text('No hay citas para este día.')];
    }

    return widget.list.map(
      (a) => AppointmentCard(appointment: a),
    ).toList();
  }
}
