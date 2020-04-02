import 'package:flutter/material.dart';

import 'package:bitmec/my_theme.dart';

class MySubmitButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  MySubmitButton({
    Key key,
    this.label = 'Guardar',
    @required this.onPressed,
  }) : super(key: key);

  @override
  _MySubmitButtonState createState() => _MySubmitButtonState();
}

class _MySubmitButtonState extends State<MySubmitButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: MyTheme.tenPadding,
          child: ButtonTheme(
            minWidth: 150.0,
            height: 50.0,
            child: RaisedButton(
              child: Text(widget.label, style: TextStyle(fontSize: 20.0)),
              textColor: MyTheme.white,
              color: MyTheme.orange,
              onPressed: widget.onPressed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
                side: BorderSide(color: MyTheme.orange),
              ),
            ),
          ),
        )
      ],
    );
  }
}
