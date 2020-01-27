import 'package:bitmec/screens.dart';
import 'package:flutter/material.dart';

import 'package:bitmec/components.dart';
import 'package:bitmec/models.dart';
import 'package:bitmec/providers.dart';

class AppointmentListByPatientScreen extends StatefulWidget {
  static const routeName = '/appointment/list/by_patient';

  @override
  _AppointmentListByPatientScreenState createState() =>
      _AppointmentListByPatientScreenState();
}

class _AppointmentListByPatientScreenState
    extends State<AppointmentListByPatientScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  AppointmentProvider _provider;
  PatientProvider _patientProvider;

  @override
  Widget build(BuildContext context) {
    if (_provider == null) {
      setState(() {
        _provider = AppointmentProvider.of(context);

        if (_provider.dataLoaded == false) {
          _provider.fetchAll();
        }
      });
    }

    if (_patientProvider == null) {
      setState(() {
        _patientProvider = PatientProvider.of(context);
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
      scaffoldKey: _scaffoldKey,
      title: 'Citas',
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppointmentCreateUpdateScreen.routeName,
              arguments: {'method': 'create'}
            );
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
                    _buildTopHeader(context),
                    _buildAppointments(context),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Future _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _provider.dataLoaded = false;
      _provider.fetchAll((response) {
        setState(() {
          _provider.dataLoaded = true;
        });
      });
    });

    return;
  }

  Widget _buildTopHeader(context) {
    return Column(
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
                  _patientProvider.object.profilePicture ?? 'https://maxcdn.icons8.com/Share/icon/Users//user_male_circle_filled1600.png'
                ),
              ),
            ),
          ),
        ),

        Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: Text('${_patientProvider.object.firstName} ${_patientProvider.object.lastName}',
            style: TextStyle(fontSize: 25.0),
          ),
        ),
      ],
    );
  }

  Widget _buildAppointments(BuildContext context) {
    bool test(Appointment appointment) =>
        appointment.patient.id == _patientProvider.object.id;

    final children = _provider.data.where(test).map(
      (a) => _buildCard(context, a),
    ).toList();

    return Column(
      children: children.isEmpty
          ? [Text('No hay citas agregadas')]
          : children,
    );
  }

  Widget _buildCard(context, Appointment appointment) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppointmentCreateUpdateScreen.routeName,
          arguments: {
            'method': 'update',
            'data': appointment,
          }
        );
      },

      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Motivo: ${appointment.formattedType()}',
                    style: TextStyle(color: Colors.orangeAccent),
                  ),

                  Text(appointment.consultation.name),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: FormattedDate(appointment.scheduled,
                      prefix: 'Fecha programado: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  FormattedDate(appointment.start, prefix: 'Inicio: '),
                  FormattedDate(appointment.end, prefix: 'Fin: '),
                ],
              ),

              RaisedButton(
                textColor: Colors.white,
                child: Text('Tomar Cita'),
                color: Colors.orangeAccent,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    ConsultationDetailScreen.routeName,
                    arguments: {'id': appointment.consultation.id},
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
