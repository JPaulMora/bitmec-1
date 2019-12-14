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
      padding: EdgeInsets.symmetric(
        horizontal: widget.noPadding ? 0.0 : 15.0,
        vertical: widget.noPadding ? 0.0 : 10.0,
      ),
      child: TextFormField(
        controller: widget.ctrl,
        enabled: widget.isEnabled(),
        autovalidate: true,
        focusNode: widget.node,
        textInputAction: widget.action,
        onFieldSubmitted: widget.submitted,
        validator: widget.validator,
        maxLines: widget.maxLines,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          icon: widget.icon,
          labelText: widget.label,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: _getColor(context)),
          ),
          labelStyle: _theme.inputDecorationTheme.labelStyle.copyWith(
            color: _getColor(context),
          ),
        ),
      ),
    );
  }

  Color _getColor(BuildContext context) {
    if (widget.validator(widget.ctrl.text) != null) {
      return _theme.errorColor;
    }

    return _theme.hintColor;
  }
}
