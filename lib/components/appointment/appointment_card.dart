import 'package:flutter/material.dart';

import 'package:bitmec/my_theme.dart';
import 'package:bitmec/components.dart';
import 'package:bitmec/models.dart';
import 'package:bitmec/screens.dart';
import 'package:bitmec/providers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppointmentCard extends StatefulWidget {
  final Appointment appointment;

  AppointmentCard({this.appointment});

  @override
  _AppointmentCardState createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  AppointmentProvider _provider;
  ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    if (_provider == null) {
      setState(() {
        _provider = AppointmentProvider.of(context);
      });
    }

    if (_theme == null) {
      setState(() {
        _theme = Theme.of(context);
      });
    }

    return GestureDetector(
      onTap: () => _onTap(context),
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
  }

  void _onTap(context) {
    if (widget.appointment.ambassador == null) {
      widget.appointment.ambassador = Ambassador(id: 1);

      _provider.update(widget.appointment, (appointment) {
        Navigator.pushNamed(
          context,
          ConsultationDetailScreen.routeName,
          arguments: {
            'method': 'update',
            'id': widget.appointment.consultation.id,
          }
        );
      });
    } else {
      Navigator.pushNamed(
        context,
        ConsultationDetailScreen.routeName,
        arguments: {
          'method': 'update',
          'id': widget.appointment.consultation.id,
        }
      );
    }
  }

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
          Text(widget.appointment.patient.fullName,
            style: headerTextStyle),
          Container(height: 10.0),
          Text('Consulta: ${widget.appointment.consultation.name}',
            style: subHeaderTextStyle),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            height: 2.0,
            width: 18.0,
            color: MyTheme.skyBlue,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RowWithIcon(
                icon: FontAwesomeIcons.edit,
                text: 'Tipo: ${widget.appointment.appointmentType}',
              ),

              RowWithIcon(
                icon: FontAwesomeIcons.calendar,
                text: FormattedDate(
                  widget.appointment.scheduled,
                  format: 'dd/MM/yyyy hh:mm a',
                  textAlign: TextAlign.end,
                ).formatted,
              ),
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
          border: Border.all(color: MyTheme.skyBlue, width: 2.5),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              widget.appointment.patient.profilePicture
                  ?? 'https://maxcdn.icons8.com/Share/icon/Users//user_male_circle_filled1600.png',
            ),
          )
      ),
    ),
  );
}
