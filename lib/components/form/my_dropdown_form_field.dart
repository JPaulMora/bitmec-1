import 'package:bitmec/my_theme.dart';
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
      padding: MyTheme.tenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildInput(context),
          _buildError(context),
        ],
      ),
    );
  }

  Widget _buildError(context) {
    if (widget.validator(widget.value) != null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 0.0, 0.0),
        child: Text(widget.validator(widget.value).toString(),
          style: TextStyle(
            color: _theme.errorColor,
            fontSize: 12.0,
          ),
        ),
      );
    }

    return Container();
  }

  Widget _buildInput(context) {
    return Container(
      height: 60.0,
      child: Stack(
        children: <Widget>[
          _buildInputContent(context),
          _buildLabel(context),
        ],
      ),
    );
  }

  Color _getColor() {
    if (widget.validator(widget.value) != null) {
      return _theme.errorColor;
    }

    return MyTheme.grey;
  }

  Widget _buildInputContent(context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(top: 8.0),
      height: 52.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: _getColor(),
          width: 1.2,
        ),
        borderRadius: MyTheme.borderRadius,
      ),

      child: Builder(builder: (BuildContext context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => onTap(context),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  widget.items.firstWhere((i) => i.value == widget.value).child,
                  Icon(Icons.arrow_drop_down, color: Colors.grey[500])
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildLabel(BuildContext context) {
    return Positioned(
      top: 4.0,
      left: 10.0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.0),
        height: 10.0,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Text(widget.label,
          style: TextStyle(
            color: MyTheme.skyBlue,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  void onTap(BuildContext context) {
    Scaffold.of(context).hideCurrentSnackBar();
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildModalHeader(context),
            Divider(height: 0.0),
            _buildModalContent(context),
          ],
        ),
      )
    );
  }

  Widget _buildModalHeader(BuildContext context) {
    return Container(
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: <Widget>[
          Text(widget.label, style: MyTheme.cardHeaderTextStyle),
          Expanded(child: Container()),
          SizedBox(width: 8.0),
        ],
      ),
    );
  }

  Widget _buildModalContent(BuildContext context) {
    if (widget.items.isNotEmpty) {
      return Expanded(
        child: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            final item = widget.items[index];
            final cond = widget.value != null && widget.value == item.value;

            return ListTile(
              title: item.child,
              trailing: item.value == -1 ? null : Icon(
                cond ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                color: cond ? _theme.accentColor : Colors.grey[500],
              ),
              onTap: item.value == -1 ? () {}  : () {
                widget.onChanged(item.value);
                Navigator.pop(context);
              }
            );
          },
        ),
      );
    }

    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.search,
              color: Colors.grey[500],
              size: 72.0,
            ),
            SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'No hay items agregados',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
