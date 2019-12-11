import 'package:flutter/material.dart';

import 'package:bitmec/components/my_app_bar.dart';

class VitalSignCreateScreen extends StatefulWidget {
  static const routeName = '/vital_sign/create';

  @override
  _VitalSignCreateScreenState createState() => _VitalSignCreateScreenState();
}

class _VitalSignCreateScreenState extends State<VitalSignCreateScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return MyAppBar(
      title: 'Crear',
      scaffoldKey: _scaffoldKey,
      backLeading: true,
    );
  }
}
