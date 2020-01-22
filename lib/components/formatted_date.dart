import 'package:flutter/material.dart';

class FormattedDate extends StatelessWidget {
  final String text;
  final TextStyle style;

  FormattedDate(this.text, {this.style});

  @override
  Widget build(BuildContext context) {
    return Text(_formatted, style: style);
  }

  String get _formatted {
    if (text == null) {
      return 'Sin fecha';
    }

    final date = DateTime.parse(text);
    return '${date.day}/${date.month}/${date.year}';
  }
}
