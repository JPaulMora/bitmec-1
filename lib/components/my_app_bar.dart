import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSize {
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;

  MyAppBar({
    Key key,
    @required this.title,
    @required this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
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
