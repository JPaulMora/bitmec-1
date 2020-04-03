import 'package:bitmec/my_theme.dart';
import 'package:flutter/material.dart';

import 'package:bitmec/components.dart';
import 'package:bitmec/models.dart';

class AppointmentListView extends StatefulWidget {
  final String title;
  final Color color;
  final List<Appointment> list;

  AppointmentListView({
    @required this.title,
    this.color,
    this.list = const [],
  });

  @override
  _AppointmentListViewState createState() => _AppointmentListViewState();
}

class _AppointmentListViewState extends State<AppointmentListView> {
  @override
  Widget build(context) {
    final subtitleTheme = Theme.of(context).textTheme.subtitle;

    return Padding(
      padding: MyTheme.tenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.title,
            style: subtitleTheme.copyWith(
              fontSize: 30.0,
              color: widget.color ?? subtitleTheme.color
            ),
          ),
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
