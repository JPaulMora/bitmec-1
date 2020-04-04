import 'package:bitmec/my_theme.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  final TextEditingController ctrl;
  final FocusNode node;
  final bool Function() isEnabled;
  final ValueChanged<String> submitted;
  final FormFieldValidator<String> validator;
  final String label;
  final int maxLines;
  final TextInputAction action;
  final TextInputType keyboardType;
  final bool obscureText;
  final Icon icon;
  final bool noPadding;
  final Color fillColor;
  final TextStyle labelStyle;

  MyTextFormField({
    Key key,
    @required this.label,
    this.ctrl,
    this.node,
    this.isEnabled,
    this.submitted,
    this.validator,
    this.maxLines = 1,
    this.action = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.icon,
    this.noPadding = false,
    this.fillColor,
    this.labelStyle,
  }) : super(key: key);

  @override
  _MyTextFormFieldState createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    if (_theme == null) {
      setState(() {
        _theme = Theme.of(context);
      });
    }

    return Padding(
      padding: widget.noPadding ? const EdgeInsets.all(0) : MyTheme.tenPadding,
      child: TextFormField(
        enabled: widget.isEnabled(),
        controller: widget.ctrl,
        focusNode: widget.node,
        textInputAction: widget.action,
        onFieldSubmitted: widget.submitted,
        validator: widget.validator,
        maxLines: widget.maxLines,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: widget.ctrl.text.isNotEmpty ? null : TextStyle(color: Colors.grey),
          filled: widget.fillColor != null ? true : false,
          fillColor: widget.fillColor,
        ),
      ),
    );
  }
}
