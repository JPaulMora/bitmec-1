import 'package:bitmec/my_theme.dart';
import 'package:flutter/material.dart';

import 'package:bitmec/components.dart';
import 'package:bitmec/models.dart';
import 'package:bitmec/screens.dart';

class ContraceptivesSection extends StatelessWidget {
  final List<BirthControl> birthControls;

  ContraceptivesSection({
    Key key,
    @required this.birthControls,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListOfSection(
      title: 'Anticonceptivos',
      children: _buildList(context),
      onPressedAdd: () {
        Navigator.pushNamed(
          context,
          BirthControlCreateUpdateScreen.routeName,
          arguments: {'method': 'create'},
        );
      },
    );
  }

  List<Widget> _buildList(BuildContext context) {
    if (birthControls.isEmpty) {
      return [Text('Aún no anticonceptivos agregados')];
    }

    return birthControls.map(
      (bc) => _ContraceptiveCard(contraceptive: bc),
    ).toList();
  }
}

class _ContraceptiveCard extends StatelessWidget {
  final BirthControl contraceptive;

  _ContraceptiveCard({this.contraceptive});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          BirthControlCreateUpdateScreen.routeName,
          arguments: {
            'method': 'update',
            'contraceptive': contraceptive,
          }
        );
      },

      child: Card(
        child: Padding(
          padding: MyTheme.tenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(contraceptive.method, style: TextStyle(
                color: MyTheme.skyBlue,
                fontSize: 20.0,
              )),
              Padding(padding: const EdgeInsets.symmetric(vertical: 5.0)),

              Text('Diagnosticado por:',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),

              Text(contraceptive.prescribingDoctor,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                contraceptive.formattedDate(),
                textDirection: TextDirection.rtl,
                style: MyTheme.italicStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
