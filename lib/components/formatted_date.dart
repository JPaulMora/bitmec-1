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
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }
}
