import 'package:flutter/material.dart';

import 'package:bitmec/screens.dart';
import 'package:bitmec/components.dart';
import 'package:bitmec/models.dart';

class MedicalConditionsSection extends StatelessWidget {
  final List<MedicalCondition> conditions;

  MedicalConditionsSection({
    Key key,
    @required this.conditions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListOfSection(
      title: 'Padecimientos',
      onPressedAdd: () {
        Navigator.pushNamed(
          context,
          MedicalConditionCreateUpdateScreen.routeName,
          arguments: {'method': 'create'},
        );
      },

      children: _buildList(context),
    );
  }

  List<Widget> _buildList(BuildContext context) {
    if (conditions.isEmpty) {
      return [Text('Aún no hay padecimientos agregados')];
    }

    return conditions.map((c) => _MedicalConditionCard(condition: c)).toList();
  }
}

class _MedicalConditionCard extends StatelessWidget {
  final MedicalCondition condition;

  _MedicalConditionCard({
    Key key,
    this.condition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          MedicalConditionCreateUpdateScreen.routeName,
          arguments: {
            'method': 'update',
            'medicalCondition': condition,
          },
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
              Container(
                height: 150.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(condition.images.isNotEmpty
                        ? condition.images.first.file
                        : 'https://sanitationsolutions.net/wp-content/uploads/2015/05/empty-image.png'
                    ),
                  )
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(condition.condition,
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 24.0,
                    ),
                  ),

                  Padding(padding: const EdgeInsets.symmetric(vertical: 5.0)),

                  Text('Diagnosticado por:',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),

                  Text(condition.diagnosingDoctor,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              FormattedDate(condition.diagnosisDate,
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.blueAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
