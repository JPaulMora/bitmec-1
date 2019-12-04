import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bitmec/components/my_drawer.dart';
import 'package:bitmec/components/my_app_bar.dart';
import 'package:bitmec/components/appointment_components.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      key: _scaffoldKey,
      drawer: MyDrawer(),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return MyAppBar(
      scaffoldKey: _scaffoldKey,
      title: 'Citas',
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildTodayAppointments(context),
          _buildTomorrowAppointments(context),
        ],
      ),
    );
  }

  Widget _buildTodayAppointments(BuildContext context) {
    return AppointmentListView(
      title: 'Hoy',
      color: Colors.blue,
    );
  }

  Widget _buildTomorrowAppointments(BuildContext context) {
    return AppointmentListView(
      title: 'Mañana',
    );
  }
}
