import 'package:flutter/material.dart';

class MyDropdownFormField extends StatefulWidget {
  final String label;
  final Icon icon;
  final dynamic value;
  final List<DropdownMenuItem> items;
  final FormFieldValidator validator;
  final ValueChanged onChanged;

  MyDropdownFormField({
    Key key,
    @required this.label,
    this.icon,
    this.items = const [],
    this.validator,
    this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  _MyDropdownFormFieldState createState() => _MyDropdownFormFieldState();
}

class _MyDropdownFormFieldState extends State<MyDropdownFormField> {
  ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    if (_theme == null) {
      setState(() {
        _theme = Theme.of(context);
      });
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 16.0,
      ),
      child: DropdownButtonFormField(
        value: widget.value,
        items: widget.items,
        onChanged: widget.onChanged,
        validator: widget.validator,
        decoration: InputDecoration(
          labelText: widget.label,
          icon: widget.icon,
        ),
      ),
    );
  }
}
