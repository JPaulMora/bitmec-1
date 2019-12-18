import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String sendBy;
  final String message;
  final String date;
  final bool sentIt;

  ChatMessage({
    this.sendBy,
    this.message,
    this.date,
    this.sentIt = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = this.sentIt ? Colors.lightBlue : Colors.black12;
    final textColor = this.sentIt ? Colors.white : Colors.black;
    final axis = this.sentIt
        ? MainAxisAlignment.end
        : MainAxisAlignment.start;
    final textDirection = this.sentIt
        ? TextDirection.rtl
        : TextDirection.ltr;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: axis,
        children: <Widget>[
          Container(
            color: color,
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
                Text(this.sendBy, style: TextStyle(
                  color: textColor,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(this.message, style: TextStyle(
                    color: textColor,
                  )),
                ),
                Text(this.date, style: TextStyle(
                  color: textColor,
                  fontSize: 13.0,
                  fontStyle: FontStyle.italic,
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
