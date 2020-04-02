import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(this.title, style: textTheme.subtitle),
              this.onPressedAdd != null
                ? IconButton(
                  icon: Icon(Icons.add),
                  onPressed: this.onPressedAdd)
                : Container(),
            ],
          ),

          Column(children: this.children)
        ],
      ),
    );
  }
}
