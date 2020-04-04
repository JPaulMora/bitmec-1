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
      title: 'Medicamentos'.toUpperCase(),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _image(),
            Padding(
              padding: MyTheme.tenPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(prescription.drug,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20.0,
                    )
                  ),

                  Padding(padding: const EdgeInsets.symmetric(vertical: 5.0)),

                  Text('Dosis de:',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),

                  Text(prescription.formattedDescription(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  Text(
                    prescription.formattedDate(),
                    textAlign: TextAlign.end,
                    style: MyTheme.italicStyle,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _image() => Container(
    height: 150.0,
    decoration: BoxDecoration(
      color: Colors.black12,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
      image: DecorationImage(
        fit: BoxFit.cover,
        image: NetworkImage(prescription.images.isNotEmpty
            ? prescription.images.first.file
            : 'https://sanitationsolutions.net/wp-content/uploads/2015/05/empty-image.png'
        ),
      ),
    ),
  );
}
