import 'package:flutter/material.dart';

import 'package:bitmec/my_theme.dart';

class MyCustomDivider extends StatelessWidget {
  final bool noPadding;

  MyCustomDivider({ this.noPadding = false });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: noPadding ? 0.0 : 10.0),
      child: Divider(height: 10.0, color: MyTheme.grey),
    );
  }
}
