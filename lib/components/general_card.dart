import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bitmec/my_theme.dart';
import 'package:bitmec/components.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GeneralCard extends StatefulWidget {
  final Widget header;
  final Widget children;
  final Function onTap;

  GeneralCard({
    this.header,
    this.children,
    this.onTap,
  });

  @override
  _GeneralCardState createState() => _GeneralCardState();
}

class _GeneralCardState extends State<GeneralCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        child: Padding(
          padding: MyTheme.tenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  widget.header,
                  InputChip(
                    backgroundColor: Colors.white,
                    pressElevation: 1.0,
                    label: Text(''),
                    labelPadding: EdgeInsets.zero,
                    onPressed: widget.onTap,
                    avatar: Icon(
                      Icons.arrow_forward_ios,
                      size: 15.0,
                      color: MyTheme.grey,
                    ),
                  ),
                ],
              ),

              MyCustomDivider(noPadding: true),
              Padding(padding: const EdgeInsets.only(top: 5.0)),
              widget.children,
            ],
          ),
        ),
      ),
    );
  }
}
