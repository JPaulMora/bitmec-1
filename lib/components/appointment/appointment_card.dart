import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context) {
    if (_provider == null) {
      setState(() {
        _provider = AppointmentProvider.of(context);
      });
    }

    return GestureDetector(
      onTap: () {
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
      },

      child: Card(
        elevation: 5.0,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.appointment.patient.profilePicture ?? 'https://maxcdn.icons8.com/Share/icon/Users//user_male_circle_filled1600.png'),
                    ),
                  ),
                ),

                Expanded(
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
                                style: TextStyle(fontSize: 25.0)),

                            Text('${widget.appointment.patient.lastName}',
                                style: TextStyle(fontSize: 25.0)),

                            Text('Tipo De Consulta: ${widget.appointment.appointmentType}'),

                            Text(widget.appointment.consultation.name)
                          ],
                        ),

                        Text(DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(widget.appointment.scheduled)),
                          textAlign: TextAlign.end)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
