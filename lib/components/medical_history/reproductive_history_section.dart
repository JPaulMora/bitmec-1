import 'package:flutter/material.dart';

import 'package:bitmec/my_theme.dart';
import 'package:bitmec/components.dart';
import 'package:bitmec/models.dart';
import 'package:bitmec/screens.dart';

class ReproductiveHistorySection extends StatelessWidget {
  final ReproductiveHistory reproductiveHealth;

  ReproductiveHistorySection({ @required this.reproductiveHealth });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Salud Reproductiva',
                  style: Theme.of(context).textTheme.subtitle),

              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    ReproductiveHistoryCreateUpdateScreen.routeName,
                    arguments: {
                      'reproductiveHealth': reproductiveHealth,
                    },
                  );
                },
              ),
            ],
          ),
          _buildCard(context),

        ],
      ),
    );
  }

  Widget _buildCard(context) {
    return Card(
      child: Padding(
        padding: MyTheme.tenPadding,
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
              FormattedDate(reproductiveHealth.firstMenstruationDate,
                  prefix: 'Primer Mestruación: '),
              FormattedDate(reproductiveHealth.lastMenstruationDate,
                  prefix: 'Última Mestruación: '),
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
              style: TextStyle(color: MyTheme.skyBlue),
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
              style: TextStyle(color: MyTheme.skyBlue),
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
              style: TextStyle(color: MyTheme.skyBlue),
            )
          ],
        ),

        cond ? box : Container()
      ],
    );
  }
}
