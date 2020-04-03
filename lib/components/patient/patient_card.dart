import 'package:bitmec/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bitmec/my_theme.dart';
import 'package:bitmec/screens.dart';
import 'package:bitmec/models.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;

  PatientCard({ this.patient });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () {
      Navigator.pushNamed(
        context,
        PatientDetailScreen.routeName,
        arguments: {'id': patient.id},
      );
    },
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Stack(
        children: <Widget>[
          _card(context),
          _thumbnail(context),
        ],
      ),
    ),
  );

  Widget _card(context) => Container(
    child: _content(context),
    margin: const EdgeInsets.only(left: 45.0),
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.black12,
          blurRadius: 10.0,
          offset: new Offset(0.0, 10.0),
        ),
      ],
    ),
  );

  Widget _content(context) {
    final headerTextStyle = TextStyle(
      fontFamily: 'Poppins',
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    );

    final subHeaderTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 12.0,
    );

    return Container(
      margin: const EdgeInsets.fromLTRB(40.0, 15.0, 15.0, 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(height: 5.0),
          Text(patient.fullName, style: headerTextStyle),
          Container(height: 10.0),
          Text(patient.address, style: subHeaderTextStyle),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            height: 2.0,
            width: 18.0,
            color: MyTheme.skyBlue,
          ),

          Row(
            children: <Widget>[
              Expanded(child: RowWithIcon(
                icon: FontAwesomeIcons.birthdayCake,
                text: '${patient.yearsOld} años',
              )),
              Expanded(child: RowWithIcon(
                icon: FontAwesomeIcons.transgender,
                text: patient.gender ? 'Hombre' : 'Mujer',
              )),
            ],
          )
        ],
      ),
    );
  }

  Widget _thumbnail(context) => Container(
    margin: const EdgeInsets.symmetric(vertical: 15.0),
    alignment: FractionalOffset.centerLeft,
    child: Container(
      width: 75.0,
      height: 75.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: MyTheme.skyBlue,
        border: Border.all(color: MyTheme.skyBlue, width: 2.5),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            patient.profilePicture ?? 'https://maxcdn.icons8.com/Share/icon/Users//user_male_circle_filled1600.png',
          ),
        )
      ),
    ),
  );
}
