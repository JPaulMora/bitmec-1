import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:bitmec/my_theme.dart';

class MyDateTimePicker extends StatefulWidget {
  final DateTime dateTime;
  final void Function(DateTime) onChange;
  final bool noPadding;
  final String label;
  final bool timePicker;
  final bool maxNow;

  MyDateTimePicker({
    @required this.dateTime,
    @required this.onChange,
    this.noPadding = false,
    this.label = 'Fecha',
    this.timePicker = false,
    this.maxNow = true,
  });

  @override
  _MyDateTimePickerState createState() => _MyDateTimePickerState();
}

class _MyDateTimePickerState extends State<MyDateTimePicker> {
  final _ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ctrl.text = _formattedDate(widget.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { _showDatetimePicker(context); },
      child: AbsorbPointer(
        child: Padding(
          padding: widget.noPadding ? const EdgeInsets.all(0) : MyTheme.tenPadding,
          child: TextField(
            controller: _ctrl,
            decoration: InputDecoration(
              labelText: widget.label,
            ),
          ),
        ),
      ),
    );
  }

  void _showDatetimePicker(context) {
    if (widget.timePicker) {
      DatePicker.showDateTimePicker(
        context,
        showTitleActions: true,
        currentTime: this.widget.dateTime,
        maxTime: widget.maxNow ? DateTime.now() : null,
        locale: LocaleType.es,
        onChanged: (date) {
          widget.onChange(date);

          setState(() {
            _ctrl.text = _formattedDate(date);
          });
        },
      );
    } else {
      DatePicker.showDatePicker(
        context,
        showTitleActions: true,
        currentTime: this.widget.dateTime,
        maxTime: widget.maxNow ? DateTime.now() : null,
        locale: LocaleType.es,
        onChanged: (date) {
          widget.onChange(date);

          setState(() {
            _ctrl.text = _formattedDate(date);
          });
        },
      );
    }
  }

  String _formattedDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
