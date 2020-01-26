import 'package:flutter/material.dart';

import 'package:bitmec/screens.dart';
import 'package:bitmec/models.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;

  PatientCard({
    Key key,
    this.patient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: _buildCard(context),
      onTap: () {
        Navigator.pushNamed(
          context,
          PatientDetailScreen.routeName,
          arguments: {'id': patient.id},
        );
      },
    );
  }

  Widget _buildCard(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildImage(context),
              _buildContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            patient.profilePicture ?? 'https://maxcdn.icons8.com/Share/icon/Users//user_male_circle_filled1600.png',
          ),
        )
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(patient.fullName, style: TextStyle(
                    fontSize: 25.0,
                  )),
                ),

                Text('${patient.yearsOld} años'),
                Text('Cui: ${patient.governmentId}'),
              ],
            ),

            Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Text(patient.gender ? 'Hombre' : 'Mujer'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
