import 'package:bitmec/models.dart';
import 'package:flutter/material.dart';

import 'package:bitmec/screens.dart';
import 'package:bitmec/providers.dart';
import 'package:bitmec/components.dart';

class PatientListScreen extends StatefulWidget {
  static const routeName = '/patient/list';

  @override
  _PatientListScreenState createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  PatientProvider _provider;

  var _searching = false;
  final _searchingCtrl = TextEditingController();
  final _searchingNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    if (_provider == null) {
      setState(() {
        _provider = PatientProvider.of(context);

        if (_provider.dataLoaded == false) {
          _provider.fetchAll();
        }
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
    return AppBar(
      title: !_searching ? Text('Pacientes') : _searchInput(),
      centerTitle: !_searching,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          tooltip: 'Buscar',
          onPressed: () {
            setState(() {
              _searching = !_searching;
              _searchingCtrl.text = '';
             _searchingNode.unfocus();
            });
          },
        )
      ],
    );
  }

  Widget _searchInput() {
    return TextField(
      autofocus: true,
      controller: _searchingCtrl,
      focusNode: _searchingNode,
      onChanged: (_) { setState(() { }); },
      decoration: InputDecoration(
        hintText: 'Buscar',
        hintStyle: TextStyle(color: Colors.grey),
        border: InputBorder.none,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Builder(builder: (context) {
          if (_provider.dataLoaded == false) {
            return Center(child: CircularProgressIndicator());
          }

          if (_provider.data.isEmpty) {
            return ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Icon(Icons.person, size: 100.0),

                    Text('Sin Registros Disponibles', style: TextStyle(
                        fontSize: 25.0
                    )),

                    Text('Intenta recarga esta pantalla nuevamente'),
                  ],
                ),
              ],
            );
          }

          return _buildList(context);
        }),
      ),
    );
  }

  Future _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _provider.dataLoaded = false;
      _provider.fetchAll((response) {
        _provider.dataLoaded = true;
      });
    });

    return;
  }

  Widget _buildList(BuildContext context) {
    bool test(Patient patient) {
      final exp = RegExp(_searchingCtrl.text.toLowerCase());
      final fullName = '${patient.firstName} ${patient.lastName}'.toLowerCase();
      return exp.hasMatch(fullName);
    }

    final items = _provider.data.where(test).toList();

    return Scrollbar(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i) => PatientCard(patient: items[i]),
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10.0,
        ),
      ),
    );
  }
}
