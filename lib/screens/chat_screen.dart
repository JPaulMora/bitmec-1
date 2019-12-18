import 'package:flutter/material.dart';

import 'package:bitmec/components/my_app_bar.dart';
import 'package:bitmec/components/chat/chat_components.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _msgCtrl = TextEditingController();

  List<MessageModel> _msgList = [
    MessageModel(
      sendBy: 'Ana',
      date: '17/03/2019',
      message: 'asjdhasjdaksd',
    ),
    MessageModel(
      sendBy: 'Ana',
      date: '17/03/2019',
      message: 'sakdjasdasjd',
    ),
    MessageModel(
      sendBy: 'Ana',
      date: '17/03/2019',
      message: '119191919',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          scaffoldKey: _scaffoldKey,
          title: 'Chat',
          backLeading: true,
        ),
        body: _buildBody(context),
        bottomSheet: _buildBottomSheet(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 75.0),
        child: Column(children: _msgToWidget(context)),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      child: Form(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.camera),
              onPressed: () {},
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  controller: _msgCtrl,
                  decoration: InputDecoration(
                    isDense: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  )
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    setState(() {
      _msgList.add(MessageModel(
        sendBy: 'Me',
        date: 'Hoy',
        sentIt: true,
        message: _msgCtrl.text,
      ));

      _msgCtrl.text = '';
    });
  }

  List<Widget> _msgToWidget(BuildContext context) {
    return _msgList.map((msg) => ChatMessage(
      sendBy: msg.sendBy,
      message: msg.message,
      date: msg.date,
      sentIt: msg.sentIt,
    )).toList();
  }
}

class MessageModel {
  final String sendBy;
  final String message;
  final String date;
  final bool sentIt;

  MessageModel({
    this.sendBy,
    this.message,
    this.date,
    this.sentIt = false,
  });
}
