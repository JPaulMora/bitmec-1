import 'package:flutter/material.dart';

import 'package:bitmec/my_theme.dart';

class RowWithIcon extends StatelessWidget {
  final IconData icon;
  final String text;

  RowWithIcon({ this.icon, this.text });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: textTheme.body2.fontSize - 5, color: MyTheme.skyBlue),
          Padding(padding: const EdgeInsets.only(left: 5.0)),
          Text(text, style: textTheme.body2)
        ],
      ),
    );
  }
}
