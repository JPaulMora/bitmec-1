import 'package:flutter/material.dart';

class MySubmitButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  MySubmitButton({
    Key key,
    @required this.label,
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
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 10.0,
          ),
          child: ButtonTheme(
            minWidth: 150.0,
            height: 50.0,
            child: RaisedButton(
              child: Text(widget.label, style: TextStyle(fontSize: 25.0)),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: widget.onPressed,
            ),
          ),
        )
      ],
    );
  }
}
