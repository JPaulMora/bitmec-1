import 'package:flutter/material.dart';

import 'package:bitmec/my_theme.dart';

class ListOfSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final VoidCallback onPressedAdd;

  ListOfSection({
    Key key,
    @required this.title,
    this.children = const <Widget>[],
    this.onPressedAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: MyTheme.tenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(this.title.toUpperCase(), style: textTheme.subtitle),
              this.onPressedAdd != null
                ? IconButton(
                  icon: Icon(Icons.add),
                  onPressed: this.onPressedAdd)
                : Container(),
            ],
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            height: 2.0,
            width: 18.0,
            color: MyTheme.primary,
          ),

          Column(children: this.children)
        ],
      ),
    );
  }
}
