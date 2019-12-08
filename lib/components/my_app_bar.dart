import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSize {
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final List<Widget> actions;

  MyAppBar({
    Key key,
    @required this.title,
    @required this.scaffoldKey,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: this.actions,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () { scaffoldKey.currentState.openDrawer(); },
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      ),
    );
  }

  @override
  Widget get child => null;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
