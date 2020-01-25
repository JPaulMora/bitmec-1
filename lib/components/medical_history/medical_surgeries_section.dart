import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bitmec/components.dart';
import 'package:bitmec/models.dart';
import 'package:bitmec/screens.dart';

class MedicalSurgeriesSection extends StatelessWidget {
  final List<Surgery> surgeries;

  MedicalSurgeriesSection({@required this.surgeries});

  @override
  Widget build(BuildContext context) {
    return ListOfSection(
      title: 'Cirugias',
      children: _buildList(context),
      onPressedAdd: () {
        Navigator.pushNamed(
          context,
          MedicalSurgeryCreateUpdateScreen.routeName,
          arguments: {'method': 'create'},
        );
      },
    );
  }

  List<Widget> _buildList(BuildContext context) {
    if (surgeries.isEmpty) {
      return [Text('Aún no hay operaciones agregadas')];
    }

    return surgeries.map
      ((s) =>_MedicalSurgeryCard(surgery: s) ,
    ).toList();
  }
}

class _MedicalSurgeryCard extends StatelessWidget {
  final Surgery surgery;

  _MedicalSurgeryCard({
    Key key,
    this.surgery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          MedicalSurgeryCreateUpdateScreen.routeName,
          arguments: {
            'method': 'update',
            'surgery': surgery,
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
              Container(
                height: 150.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(surgery.images.isNotEmpty
                        ? surgery.images.first.file
                        : 'https://sanitationsolutions.net/wp-content/uploads/2015/05/empty-image.png'
                    ),
                  ),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(surgery.operation,
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 24.0,
                    ),
                  ),

                  Padding(padding: const EdgeInsets.symmetric(vertical: 5.0)),

                  Text('Realizada por:',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                  Text(surgery.operatingDoctor,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              FormattedDate(surgery.operationDate,
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.blueAccent),
              )
            ],
          ),
        ),
      ),
    );
  }
}
