import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSize {
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final List<Widget> actions;
  final bool backLeading;

  MyAppBar({
    Key key,
    @required this.title,
    @required this.scaffoldKey,
    this.actions,
    this.backLeading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Widget get child => null;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
