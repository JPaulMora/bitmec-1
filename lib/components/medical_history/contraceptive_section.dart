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
      ),
    );
  }
}
