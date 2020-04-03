import 'package:bitmec/my_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuickActionsSection extends StatelessWidget {
  final List<QuickActionIcon> children;

  QuickActionsSection({ this.children });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MyTheme.tenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(0.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: children,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class QuickActionIcon extends StatelessWidget {
  final Icon icon;
  final Color color;
  final String label;
  final Color textColor;
  final GestureTapCallback onTap;

  QuickActionIcon({
    @required this.icon,
    this.color,
    this.label,
    this.textColor = MyTheme.white,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: MyTheme.tenPadding,
        child: Column(
          children: <Widget>[
            Material(
              color: this.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
              child: IconButton(
                icon: icon,
                color: textColor,
                iconSize: 30.0,
                onPressed: onTap,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(label),
            )
          ],
        ),
      ),
    );
  }
}
