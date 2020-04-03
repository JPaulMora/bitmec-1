import 'package:bitmec/components.dart';
import 'package:flutter/material.dart';

import 'package:bitmec/my_theme.dart';
import 'package:bitmec/screens.dart';
import 'package:bitmec/models.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      child: Padding(
        padding: MyTheme.tenPadding,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
      width: 75.0,
      height: 75.0,
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

  Widget _buildContent(context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(patient.firstName, style: MyTheme.cardHeaderTextStyle),
            Text(patient.lastName, style: MyTheme.cardHeaderTextStyle),

            RowWithIcon(
              icon: FontAwesomeIcons.birthdayCake,
              text: '${patient.yearsOld} años',
            ),

            RowWithIcon(
              icon: FontAwesomeIcons.idCard,
              text: patient.governmentId.toString(),
            ),

            RowWithIcon(
              icon: FontAwesomeIcons.transgender,
              text: patient.gender ? 'Hombre' : 'Mujer',
            ),
          ],
        ),
      ),
    );
  }
}
