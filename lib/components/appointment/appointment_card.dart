import 'package:flutter/material.dart';

import 'package:bitmec/my_theme.dart';
import 'package:bitmec/components.dart';
import 'package:bitmec/models.dart';
import 'package:bitmec/screens.dart';
import 'package:bitmec/providers.dart';

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
      child: Card(
        child: Padding(
          padding: MyTheme.tenPadding,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildImage(context),
                _buildInfo(context),
              ],
            ),
          ),
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

  Widget _buildImage(context) {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(widget.appointment.patient.profilePicture ?? 'https://maxcdn.icons8.com/Share/icon/Users//user_male_circle_filled1600.png'),
        ),
      ),
    );
  }

  Widget _buildInfo(context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${widget.appointment.patient.firstName}',
                  style: MyTheme.cardHeaderTextStyle),

                Text('${widget.appointment.patient.lastName}',
                  style: MyTheme.cardHeaderTextStyle),

                Text('Tipo De Consulta: ${widget.appointment.appointmentType}',
                  style: _theme.textTheme.body2.copyWith(
                    color: MyTheme.skyBlue,
                  )),

                Text(widget.appointment.consultation.name,
                  style: _theme.textTheme.body2),
              ],
            ),

            FormattedDate(
              widget.appointment.scheduled,
              format: 'dd/MM/yyyy hh:mm a',
              textAlign: TextAlign.end,
            )
          ],
        ),
      ),
    );
  }
}
