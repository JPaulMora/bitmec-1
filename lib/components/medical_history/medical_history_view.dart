import 'package:flutter/material.dart';

import 'package:bitmec/components.dart';
import 'package:bitmec/providers.dart';
import 'package:bitmec/models.dart';

class MedicalHistoryView extends StatefulWidget {
  @override
  _MedicalHistoryViewState createState() =>
      _MedicalHistoryViewState();
}

class _MedicalHistoryViewState extends State<MedicalHistoryView> {
  PatientProvider _provider;

  @override
  Widget build(BuildContext context) {
    if (_provider == null) {
      setState(() {
        _provider = PatientProvider.of(context);
      });
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MedicalConditionsSection(
            conditions: _provider.object.historicalConditions,
          ),

          MedicalSurgeriesSection(
            surgeries: _provider.object.historicalOperations,
          ),

          MedicalPrescriptionSection(
            medicines: _provider.object.historicalPrescriptions,
          ),

          _provider.object.gender ? Container() :
            _ReproductiveHealthSection(
              reproductiveHealth: _provider.object.reproductiveHistory.first
            ),

          _ContraceptivesSection(
            birthControls: _provider.object.birthControls,
          ),
        ],
      ),
    );
  }
}

class _ReproductiveHealthSection extends StatelessWidget {
  final ReproductiveHistory reproductiveHealth;

  _ReproductiveHealthSection({
    Key key,
    @required this.reproductiveHealth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Salud Reproductiva', style: TextStyle(
            fontSize: 30.0,
            color: Colors.blue
          )),

          Card(
            elevation: 3.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 10.0,
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildRow1(context),
                  _buildRow2(context),
                  _buildRow3(context),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRow1(BuildContext context) {
    final cond = reproductiveHealth.firstMenstruationDate != null;
    final box = Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        color: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Primer Mestruación: ${reproductiveHealth.formattedFirstMenstruationDate()}'),
              Text('Última Mestruación: ${reproductiveHealth.formattedLastMenstruationDate()}'),
            ],
          ),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('¿Has tenido uno más ciclos mestruales?'),
            Text(cond ? 'Sí' : 'No',
              style: TextStyle(color: Colors.blueAccent),
            )
          ],
        ),

        cond ? box : Container()
      ],
    );
  }

  Widget _buildRow2(BuildContext context) {
    final cond = reproductiveHealth.pregnancies > 0;
    final box = Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        color: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Embarazos: ${reproductiveHealth.pregnancies}'),
              Text('Hijos vivos: ${reproductiveHealth.liveBirths}'),
            ],
          ),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('¿Has estado embarazada?'),
            Text(cond ? 'Sí' : 'No',
              style: TextStyle(color: Colors.blueAccent),
            )
          ],
        ),

        cond ? box : Container(),
      ],
    );
  }

  Widget _buildRow3(BuildContext context) {
    final cond = reproductiveHealth.abortions > 0;
    final box = Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        color: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Abortos: ${reproductiveHealth.abortions}'),
              Text('Perdidad Naturales: ${reproductiveHealth.stillborns}'),
            ],
          ),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('¿Ha perdido algun bebé aún no nacido'),
            Text(cond ? 'Sí' : 'No',
              style: TextStyle(color: Colors.blueAccent),
            )
          ],
        ),

        cond ? box : Container()
      ],
    );
  }
}

class _ContraceptivesSection extends StatelessWidget {
  final List<BirthControl> birthControls;

  _ContraceptivesSection({
    Key key,
    @required this.birthControls,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListOfSection(
      title: 'Anticonceptivos',
      children: _buildList(context),
    );
  }

  List<Widget> _buildList(BuildContext context) {
    if (birthControls.isEmpty) {
      return [Text('Aún no hay operaciones agregadas')];
    }

    return birthControls.map((bc) =>
        _ContraceptiveCard(contraceptive: bc),
    ).toList();
  }
}

class _ContraceptiveCard extends StatelessWidget {
  final BirthControl contraceptive;

  _ContraceptiveCard({this.contraceptive});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(contraceptive.method, style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 24.0,
                )),
                Padding(padding: const EdgeInsets.symmetric(vertical: 5.0)),
                Text('Desde ${contraceptive.formattedStartDate()} hasta ${contraceptive.formattedEndDate()}'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
