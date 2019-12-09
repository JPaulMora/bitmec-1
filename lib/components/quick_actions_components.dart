import 'package:flutter/material.dart';

class QuickActionsSection extends StatelessWidget {
  final List<QuickActionIcon> children;

  QuickActionsSection({
    Key key,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(0.0),
            elevation: 5.0,
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
  final Color textColor;
  final String tooltip;

  QuickActionIcon({
    @required this.icon,
    this.color,
    this.textColor = Colors.white,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        color: this.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
            tooltip: this.tooltip,
            icon: this.icon,
            color: this.textColor,
            iconSize: 50.0,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
