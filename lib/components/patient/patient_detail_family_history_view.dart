import 'package:flutter/material.dart';

import 'package:bitmec/screens.dart';
import 'package:bitmec/components.dart';
import 'package:bitmec/models.dart';
import 'package:bitmec/providers.dart';

class PatientDetailFamilyHistoryView extends StatefulWidget {
  @override
  _PatientDetailFamilyHistoryViewState createState() =>
      _PatientDetailFamilyHistoryViewState();
}

class _PatientDetailFamilyHistoryViewState
    extends State<PatientDetailFamilyHistoryView> {
  PatientProvider _provider;

  @override
  Widget build(BuildContext context) {
    if (_provider == null) {
      setState(() {
        _provider = PatientProvider.of(context);
      });
    }

    return SingleChildScrollView(
      child: ListOfSection(
        title: 'Familia',
        onPressedAdd: () {
          Navigator.pushNamed(
            context,
            FamilyHistoryCreateUpdateScreen.routeName,
            arguments: {'method': 'create'}
          );
        },

        children: _buildList(context),
      ),
    );
  }

  List<Widget> _buildList(context) {
    if (_provider.object.familyMembers.isEmpty) {
      return [Text('NO hay familiares agregados')];
    }

    return _provider.object.familyMembers.map(
      (m) => _FamilyCard(member: m),
    ).toList();
  }
}

class _FamilyCard extends StatelessWidget {
  final FamilyMemberCondition member;

  _FamilyCard({this.member});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          FamilyHistoryCreateUpdateScreen.routeName,
          arguments: {
            'method': 'update',
            'member': member,
          }
        );
      },

      child: Card(
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
                  Text(member.relative, style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 24.0,
                  )),

                  Padding(padding: const EdgeInsets.symmetric(vertical: 5.0)),
                  Text('Condición: ${member.condition}'),
                ],
              ),

              FormattedDate(member.dateDiagnosed,
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
