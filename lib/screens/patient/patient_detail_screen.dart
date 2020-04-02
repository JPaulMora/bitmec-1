import 'package:flutter/material.dart';

import 'package:bitmec/my_theme.dart';
import 'package:bitmec/components.dart';
import 'package:bitmec/screens.dart';
import 'package:bitmec/providers.dart';

class PatientDetailScreen extends StatefulWidget {
  static const routeName = '/patient/detail';

  @override
  _PatientDetailScreenState createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  PatientProvider _provider;

  @override
  void dispose() {
    _provider.removeObject();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_provider == null) {
      Map args = ModalRoute.of(context).settings.arguments;

      setState(() {
        _provider = PatientProvider.of(context);
        _provider.fetchById(args['id']);
      });
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return MyAppBar(
      title: 'Detalle',
      scaffoldKey: _scaffoldKey,
      backLeading: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            Navigator.pushNamed(context, PatientEditScreen.routeName);
          },
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Builder(builder: (context) {
        if (_provider.objectLoaded == false) {
          return Center(child: CircularProgressIndicator());
        }

        return DefaultTabController(
          length: 4,
          child: Column(
            children: <Widget>[
              _buildTopHeader(context),
              _buildTabBar(context),
              _buildContent(context),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTopHeader(BuildContext context) {
    final style = TextStyle(
      color: MyTheme.black,
      fontSize: 30.0,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    _provider.object.profilePicture ?? 'https://maxcdn.icons8.com/Share/icon/Users//user_male_circle_filled1600.png'
                  ),
                )
              ),
            ),
          ),

          Text(_provider.object.firstName, style: style),
          Text(_provider.object.lastName, style: style),
        ],
      ),
    );
  }

  Widget _buildTabBar(context) {
    return Material(
      color: Colors.lightBlueAccent,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TabBar(
              isScrollable: true,
              labelColor: Colors.white,
              indicatorColor: MyTheme.skyBlue,
              indicatorWeight: 5.0,

              tabs: <Widget>[
                Tab(child: Text('General')),
                Tab(child: Text('Historial Médico')),
                Tab(child: Text('Historial Familiar')),
                Tab(child: Text('Hábitos')),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContent(context) {
    return Expanded(
      child: TabBarView(
        children: <Widget>[
          PatientDetailGeneralView(),
          MedicalHistoryView(),
          PatientDetailFamilyHistoryView(),
          PatientDetailHabitsView(),
          // TODO: implement dependent
        ],
      ),
    );
  }
}
