import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:bitmec/my_theme.dart';

class FormattedDate extends StatelessWidget {
  final String text;
  final String prefix;
  final TextAlign textAlign;
  final TextStyle style;
  final Color color;
  final String format;

  FormattedDate(this.text, {
    this.prefix = '',
    this.textAlign,
    this.style,
    this.color,
    this.format = 'dd/MM/yyyy',
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$prefix$_formatted',
      textAlign: textAlign,
      style: MyTheme.italicStyle.copyWith(
        color: color ?? MyTheme.italicStyle.color,
      ),
    );
  }

  String get _formatted {
    if (text == null) return 'Sin fecha';

    final date = DateTime.parse(text);
    return DateFormat(format).format(date);
  }
}
