import 'package:flutter/material.dart';

//class MyAppBar extends StatefulWidget implements PreferredSize {
//  GlobalKey<ScaffoldState> scaffoldKey;
//  String title;
//
//  MyAppBar({
//    Key key,
//    @required this.scaffoldKey,
//    this.title = 'Default Title, Please Change It!',
//  }) : super(key: key) ;
//
//  @override
//  _MyAppBarState createState() => _MyAppBarState();
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return null;
//  }
//
//  @override
//  // TODO: implement child
//  Widget get child => null;
//
//  @override
//  // TODO: implement preferredSize
//  Size get preferredSize => null;
//}
//
//class _MyAppBarState extends State<MyAppBar> {
//  @override
//  Widget build(BuildContext context) {
//    return AppBar(
//      title: Text(widget.title),
//      centerTitle: true,
//      leading: IconButton(
//        icon: const Icon(Icons.menu),
//        onPressed: () { widget.scaffoldKey.currentState.openDrawer(); },
//        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
//      ),
//    );
//  }
//}


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
