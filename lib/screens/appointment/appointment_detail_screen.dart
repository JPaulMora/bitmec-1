import 'package:bitmec/models.dart';
import 'package:flutter/material.dart';

import 'package:bitmec/screens.dart';
import 'package:bitmec/components.dart';
import 'package:bitmec/providers.dart';

class AppointmentDetailScreen extends StatefulWidget {
  static const routeName = '/appointment/detail';

  @override
  _AppointmentDetailScreenState createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ConsultationProvider _provider;

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
        _provider = ConsultationProvider.of(context);
        _provider.fetchById(args['id']);
      });
    }

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return MyAppBar(
      title: 'Detalle',
      scaffoldKey: _scaffoldKey,
      backLeading: true,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildQuickActionsSection(context),
          _buildVitalSignsSection(context),
          _buildSymptomsSection(context),
          _buildLaboratoryOrdersSection(context),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection(BuildContext context) {
    return QuickActionsSection(
      children: <QuickActionIcon>[
        QuickActionIcon(
          icon: Icon(Icons.fiber_manual_record),
          color: Colors.red,
          label: 'Signos Vitales',
          onTap: () {
            Navigator.pushNamed(context, VitalSignCreateScreen.routeName);
          },
        ),

        QuickActionIcon(
          icon: Icon(Icons.assignment_ind),
          color: Colors.purple,
          label: 'Sintomas',
          onTap: () {
            Navigator.pushNamed(context, SymptomCreateScreen.routeName);
          },
        ),

        QuickActionIcon(
          icon: Icon(Icons.chat),
          color: Colors.green,
          label: 'Chat',
          onTap: () {
            Navigator.pushNamed(context, ChatScreen.routeName);
          },
        ),

        QuickActionIcon(
          icon: Icon(Icons.dock),
          color: Colors.lightBlueAccent,
          label: 'Consulta',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildVitalSignsSection(BuildContext context) {
    List<Widget> _list() {
      if (_provider.object.vitalSigns.isEmpty) {
        return [Text('No hay signos vitales agregados')];
      }

      return _provider.object.vitalSigns.map(
        (vs) => _VitalSignCard(vitalSign: vs),
      ).toList();
    }

    return ListOfSection(
      title: 'Signos Vitales',
      children: _list(),
    );
  }

  Widget _buildSymptomsSection(BuildContext context) {
    return ListOfSection(
      title: 'Sintomas',
      children: <Widget>[
        _SymptomCard(),
      ],
    );
  }

  Widget _buildLaboratoryOrdersSection(BuildContext context) {
    return ListOfSection(
      title: 'Órdenes de Laboratorio',
      children: <Widget>[],
    );
  }
}

class _VitalSignCard extends StatelessWidget {
  final VitalSign vitalSign;

  _VitalSignCard({this.vitalSign});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0, vertical: 10.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(vitalSign.formattedDate(), textAlign: TextAlign.end),
              Padding(padding: const EdgeInsets.only(top: 10.0)),
              Container(
                color: Colors.black12,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: [
                      _buildField('Peso', '${vitalSign.weight} libras'),
                      _buildField('Altura', '${vitalSign.height} metros'),
                      _buildField('Sistólica', vitalSign.systolicPressure.toString()),
                      _buildField('Diastólica', vitalSign.diastolicPressure.toString()),
                      _buildField('Frecuencia Cardiaca', '${vitalSign.heartRate} ppm'),
                      _buildField('Oxígeneo', '${vitalSign.oxygen}%'),
                      _buildField('Temperatura', '${vitalSign.temperature} grados'),
                      _buildField('Glucosa', '${vitalSign.glucose} mg/dl'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String description, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('$description:'),
          Text(value, style: TextStyle(
            fontWeight: FontWeight.bold,
          )),
        ],
      ),
    );
  }
}

class _SymptomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0, vertical: 10.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('Ardor', style: TextStyle(
                fontSize: 20.0,
                color: Colors.blue,
              )),
              Text('09 Diciembre 2019', style: TextStyle(
                fontSize: 12.0,
              )),

              Padding(padding: const EdgeInsets.only(top: 10.0)),

              Container(
                color: Colors.black12,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Cabeza', style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      )),
                      Text('Magnitud: 9')
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
