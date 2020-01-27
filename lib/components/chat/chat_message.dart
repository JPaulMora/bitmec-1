import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart' as intl;

import 'package:bitmec/models.dart';

class ChatMessage extends StatelessWidget {
  final Message message;

  ChatMessage({this.message});

  @override
  Widget build(BuildContext context) {
    String sendBy = 'Sin enviador registrado';

    if (message.doctor != null) {
      sendBy = 'Dr ${message.doctor.firstName} ${message.doctor.lastName}';
    } else if (message.ambassador != null) {
      sendBy = '${message.ambassador.firstName} ${message.ambassador.lastName}';
    }

    final sentIt = message.doctor == null;

    final color = sentIt ? Colors.lightBlue : Colors.black12;
    final textColor = sentIt ? Colors.white : Colors.black;
    final axis = sentIt ? MainAxisAlignment.end : MainAxisAlignment.start;
    final textDirection = sentIt ? TextDirection.rtl : TextDirection.ltr;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: axis,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),

            constraints: BoxConstraints(
              minWidth: 150,
              maxWidth: 250,
            ),

            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 10.0
            ),

            child: Column(
              textDirection: textDirection,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(sendBy, style: TextStyle(
                  color: textColor,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold
                )),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(message.message, style: TextStyle(
                    color: textColor,
                  )),
                ),

                Text(
                  intl.DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(message.timestamp)),
                  style: TextStyle(
                    color: textColor,
                    fontSize: 13.0,
                    fontStyle: FontStyle.italic,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
