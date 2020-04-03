import 'package:flutter/material.dart';

import 'package:bitmec/my_theme.dart';
import 'package:bitmec/components.dart';
import 'package:bitmec/screens.dart';
import 'package:bitmec/providers.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:bitmec/models.dart';

class PatientDetailScreen extends StatefulWidget {
  static const routeName = '/patient/detail';

  @override
  _PatientDetailScreenState createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  PatientProvider _provider;
  ConsultationProvider _consultationProvider;

  final _consultationCtrl = TextEditingController();
  final _consultationNode = FocusNode();

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

    if (_consultationProvider == null) {
      setState(() {
        _consultationProvider = ConsultationProvider.of(context);
      });
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButton: _buildSpeedDial(context),
    );
  }

  Widget _buildSpeedDial(context) {
    return SpeedDial(
      elevation: 0,
      backgroundColor: MyTheme.skyBlue,
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(color: Colors.white),
      overlayOpacity: 0.0,
      children: [
        SpeedDialChild(
          child: Icon(Icons.add, color: MyTheme.white),
          backgroundColor: MyTheme.orange,
          onTap: () => _createConsultation(context),
        ),

        SpeedDialChild(
          child: Icon(Icons.calendar_today, color: MyTheme.white),
          backgroundColor: MyTheme.skyBlue,
          onTap: () {
            Navigator.pushNamed(
              context,
              AppointmentListByPatientScreen.routeName
            );
          },
        ),

        SpeedDialChild(
          child: Icon(Icons.attach_money, color: MyTheme.white),
          backgroundColor: Colors.green,
          onTap: () => {},
        ),
      ],
    );
  }

  void _createConsultation(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Agregar Consulta'),
        content: MyTextFormField(
          noPadding: true,
          label: 'Nombre',
          ctrl: _consultationCtrl,
          node: _consultationNode,
          isEnabled: () => true,
          submitted: (_) {},
          validator: (value) => value.trim().isEmpty
              ? 'El valor es requerido' : null,
        ),

        actions: <Widget>[
          FlatButton(
            splashColor: Colors.black12,
            child: Text('Agregar'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
              side: BorderSide(color: MyTheme.skyBlue)
            ),
            onPressed: () {
              final consultation = Consultation(
                name: _consultationCtrl.text,
                active: true,
                patient: _provider.object.id,
              );

              _consultationProvider.create(consultation, (c) {
                _consultationCtrl.text = '';
                _provider.addConsultation(c);
                Navigator.pop(context);
              });
            },
          ),

          RaisedButton(
            color: MyTheme.red,
            child: Text('Cancelar'),
            onPressed: () {
              _consultationCtrl.text = '';
              Navigator.pop(context);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
              side: BorderSide(color: MyTheme.red)
            ),
          ),
        ],
      ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
              width: 75.0,
              height: 75.0,
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

          Text(_provider.object.fullName, style: TextStyle(
            color: MyTheme.black,
            fontSize: 20.0,
          )),
        ],
      ),
    );
  }

  Widget _buildTabBar(context) {
    return Material(
      color: MyTheme.skyBlue,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TabBar(
              isScrollable: true,
              labelColor: Colors.white,
              indicatorColor: MyTheme.orange,
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
