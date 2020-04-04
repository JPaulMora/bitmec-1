import 'package:flutter/material.dart';

import 'package:bitmec/my_theme.dart';
import 'package:bitmec/screens.dart';
import 'package:bitmec/components.dart';
import 'package:bitmec/models.dart';

class MedicalConditionsSection extends StatelessWidget {
  final List<MedicalCondition> conditions;

  MedicalConditionsSection({@required this.conditions});

  @override
  Widget build(BuildContext context) {
    return ListOfSection(
      title: 'Padecimientos'.toUpperCase(),
      children: _buildList(context),
      onPressedAdd: () {
        Navigator.pushNamed(
          context,
          MedicalConditionCreateUpdateScreen.routeName,
          arguments: {'method': 'create'},
        );
      },
    );
  }

  List<Widget> _buildList(BuildContext context) {
    if (conditions.isEmpty) {
      return [Text('Aún no hay padecimientos agregados')];
    }

    return conditions.map(
      (c) => _MedicalConditionCard(condition: c)
    ).toList();
  }
}

class _MedicalConditionCard extends StatelessWidget {
  final MedicalCondition condition;

  _MedicalConditionCard({ this.condition });

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _image(context),
            Padding(
              padding: MyTheme.tenPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(condition.condition,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20.0,
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

                  FormattedDate(
                    condition.diagnosisDate,
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _image(context) => Container(
    height: 150.0,
    decoration: BoxDecoration(
      color: Colors.black12,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
      image: DecorationImage(
        fit: BoxFit.cover,
        image: NetworkImage(condition.images.isNotEmpty
          ? condition.images.first.file
          : 'https://sanitationsolutions.net/wp-content/uploads/2015/05/empty-image.png'
        ),
      )
    ),
  );
}
