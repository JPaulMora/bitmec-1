import 'package:flutter/material.dart';

import 'package:bitmec/my_theme.dart';
import 'package:bitmec/components.dart';
import 'package:bitmec/models.dart';
import 'package:bitmec/providers.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  AppointmentProvider _provider;

  var _filter = false;
  var _filterDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    if (_provider == null) {
      setState(() {
        _provider = AppointmentProvider.of(context);
        _provider.fetchAll();
      });
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      drawer: MyDrawer(),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return MyAppBar(
      scaffoldKey: _scaffoldKey,
      title: 'Citas',
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          tooltip: 'Buscar',
          onPressed: () {
            setState(() {
              _filter = !_filter;
            });
          },
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Builder(builder: (context) {
          if (_provider.dataLoaded == false) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildFilterSection(context),
                    _buildTodaySection(context),
                    _buildTomorrowSection(context),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Future _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _filter = false;
      _filterDate = DateTime.now();

      _provider.dataLoaded = false;
      _provider.fetchAll((response) {
        setState(() {
          _provider.dataLoaded = true;
        });
      });
    });

    return;
  }

  Widget _buildFilterSection(context) {
    if (_filter) {
      bool test(Appointment appointment) {
        if (appointment.scheduled == null) {
          return false;
        }

        final date = DateTime.parse(appointment.scheduled);

        return date.day == _filterDate.day &&
            date.month == _filterDate.month &&
            date.year == _filterDate.year;
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          MyDateTimePicker(
            dateTime: _filterDate,
            maxNow: false,
            onChange: (date) {
              setState(() {
                _filterDate = date;
              });
            },
          ),

          AppointmentListView(
            title: 'Filtro',
            color: Colors.blue,
            list: _provider.data.where(test).toList(),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Divider(height: 10.0, color: MyTheme.grey),
          )
        ],
      );
    }

    return Container();
  }

  Widget _buildTodaySection(context) {
    bool test(Appointment appointment) {
      if (appointment.scheduled == null) {
        return false;
      }

      final now = DateTime.now();
      final date = DateTime.parse(appointment.scheduled);

      return date.day == now.day &&
          date.month == now.month &&
          date.year == now.year;
    }

    return AppointmentListView(
      title: 'Hoy',
      list: _provider.data.where(test).toList(),
    );
  }

  Widget _buildTomorrowSection(context) {
    bool test(Appointment appointment) {
      if (appointment.scheduled == null) {
        return false;
      }

      final tomorrow = DateTime.now().add(Duration(days: 1));
      final date = DateTime.parse(appointment.scheduled);

      return date.day == tomorrow.day &&
          date.month == tomorrow.month &&
          date.year == tomorrow.year;
    }

    return AppointmentListView(
      title: 'Mañana',
      color: MyTheme.grey,
      list: _provider.data.where(test).toList(),
    );
  }
}
