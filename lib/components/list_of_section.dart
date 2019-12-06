import 'package:flutter/material.dart';

class ListOfSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  ListOfSection({
    Key key,
    @required this.title,
    this.children = const <Widget>[],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(this.title, style: TextStyle(
              fontSize: 30.0,
              color: Colors.blue
          )),

          Column(children: this.children)
        ],
      ),
    );
  }
}
