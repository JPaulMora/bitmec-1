import 'package:bitmec/my_app.dart';
import 'package:flutter/material.dart';

import 'package:bitmec/components/my_app_bar.dart';
import 'package:bitmec/components/my_drawer.dart';

class PatientDetailScreen extends StatefulWidget {
  static const routeName = '/patient/detail';

  @override
  _PatientDetailScreenState createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: _buildAppBar(context),
        drawer: _buildAppDrawer(context),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return MyAppBar(
      title: 'Detalle',
      scaffoldKey: _scaffoldKey,
    );
  }
  
  Widget _buildAppDrawer(BuildContext context) {
    return MyDrawer();
  }

  Widget _buildBody(BuildContext context) {
      return DefaultTabController(
        length: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://images.pexels.com/photos/235805/pexels-photo-235805.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                    )
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text('Nombre Apellido', style: TextStyle(
                  fontSize: 30.0
              )),
            ),

            _buildTabBar(context),

            Expanded(
              child: TabBarView(
                children: <Widget>[
                  Text('General'),
                  Text('Historial Médico'),
                  Text('Historial Familiar'),
                  Text('Hábito'),
                  Text('Dependientes'),
                ],
              ),
            )
          ],
        ),
      );
  }

  Widget _buildTabBar(BuildContext context) {
    return Material(
      color: Colors.lightBlueAccent,
      child: TabBar(
        isScrollable: true,
        labelColor: Colors.white,
        indicatorColor: Colors.indigoAccent,
        indicatorWeight: 5.0,
        tabs: <Widget>[
          Tab(child: Text('General')),
          Tab(child: Text('Historial Médico')),
          Tab(child: Text('Historial Familiar')),
          Tab(child: Text('Hábitos')),
          Tab(child: Text('Dependientes')),
        ],
      ),
    );
  }
}
