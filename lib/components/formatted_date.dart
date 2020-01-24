import 'package:flutter/material.dart';

class FormattedDate extends StatelessWidget {
  final String text;
  final String prefix;
  final TextAlign textAlign;
  final TextStyle style;

  FormattedDate(this.text, {
    this.prefix = '',
    this.textAlign,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$prefix$_formatted',
      textAlign: textAlign,
      style: style,
    );
  }

  String get _formatted {
    if (text == null) {
      return 'Sin fecha';
    }

    final date = DateTime.parse(text);
    return '${date.day}/${date.month}/${date.year}';
  }
}
