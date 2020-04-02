import 'package:bitmec/my_theme.dart';
import 'package:flutter/material.dart';

class QuickActionsSection extends StatelessWidget {
  final List<QuickActionIcon> children;

  QuickActionsSection({ this.children });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(0.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: children),
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Material(
              color: this.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: MyTheme.tenPadding,
                    child: IconButton(
                      icon: icon,
                      color: textColor,
                      iconSize: 25.0,
                      onPressed: onTap,
                    ),
                  ),
                ],
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
