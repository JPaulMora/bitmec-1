import 'package:flutter/material.dart';

import 'package:bitmec/my_theme.dart';
import 'package:bitmec/screens.dart';
import 'package:bitmec/components.dart';
import 'package:bitmec/models.dart';

class MedicalPrescriptionSection extends StatelessWidget {
  final List<Prescription> medicines;

  MedicalPrescriptionSection({@required this.medicines});

  @override
  Widget build(BuildContext context) {
    return ListOfSection(
      title: 'Medicamentos',
      children: _buildList(context),
      onPressedAdd: () {
        Navigator.pushNamed(
          context,
          MedicalPrescriptionCreateUpdateScreen.routeName,
          arguments: {'method': 'create'},
        );
      },
    );
  }

  List<Widget> _buildList(BuildContext context) {
    if (medicines.isEmpty) {
      return [Text('No hay medicamentos agregadas')];
    }

    return medicines.map(
      (p) => _MedicineCard(prescription: p),
    ).toList();
  }
}

class _MedicineCard extends StatelessWidget {
  final Prescription prescription;

  _MedicineCard({this.prescription});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          MedicalPrescriptionCreateUpdateScreen.routeName,
          arguments: {
            'method': 'update',
            'prescription': prescription,
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
              Container(
                height: 150.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(prescription.images.isNotEmpty
                        ? prescription.images.first.file
                        : 'https://sanitationsolutions.net/wp-content/uploads/2015/05/empty-image.png'
                    ),
                  ),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: const EdgeInsets.symmetric(vertical: 5.0)),
                  Text(prescription.drug,
                    style: TextStyle(
                      color: MyTheme.skyBlue,
                      fontSize: 20.0
                    )
                  ),

                  Padding(padding: const EdgeInsets.symmetric(vertical: 5.0)),

                  Text('Dosis de:',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),

                  Text(prescription.formattedDescription(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              Text(
                prescription.formattedDate(),
                textAlign: TextAlign.end,
                style: MyTheme.italicStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
