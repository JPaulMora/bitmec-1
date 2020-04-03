import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bitmec/components.dart';
import 'package:bitmec/providers.dart';
import 'package:bitmec/models.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  MessageProvider _provider;
  ConsultationProvider _consultationProvider;

  final _msgCtrl = TextEditingController();

  @override
  void dispose() {
    _provider.removeData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_consultationProvider == null) {
      setState(() {
        _consultationProvider = ConsultationProvider.of(context);
        print(_consultationProvider.object.id);
      });
    }

    if (_provider == null) {
      setState(() {
        _provider = MessageProvider.of(context);
        _provider.fetchAll(_consultationProvider.object.id, _refresh);
      });
    }

    return Scaffold(
      appBar: MyAppBar(
        scaffoldKey: _scaffoldKey,
        title: 'Chat',
      ),
      body: _buildBody(context),
      bottomSheet: _buildBottomSheet(context),
    );
  }

  void _refresh(_) {
    Future.delayed(Duration(seconds: 5)).then((_) {
      _provider.fetchAll(_consultationProvider.object.id, _refresh);
    });
  }

  Widget _buildBody(BuildContext context) {
    if (_provider.dataLoaded == false) {
      return SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SafeArea(
      child: _list(context),
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
              onPressed: _sendImage,
            ),

            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  controller: _msgCtrl,
                  decoration: InputDecoration(
                    hintText: 'Mensaje...',
                    hintStyle: TextStyle(color: Colors.grey),
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

  void _sendImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _provider.sendImage({
      'image': image,
      'consultation': _consultationProvider.object.id,
    });
  }

  void _sendMessage() {
    final msg = Message(
      message: _msgCtrl.text,
      ambassador: Ambassador(id: 1),
      consultation: _consultationProvider.object.id,
    );

    _provider.create(msg, (_) {
      setState(() {
        _msgCtrl.text = '';
      });
    });
  }

  Widget _list(BuildContext context) {
    bool test(msg) {
      if (msg is Message)
        return msg.consultation == _consultationProvider.object.id;

      return true;
    }

    map(msg) => ChatMessage(message: msg);

    final items = _provider.data.where(test).map(map).toList().reversed.toList();

    if (items.isEmpty) {
      return Center(child: Text('No sean enviado mensajes'));
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 75.0),
      reverse: true,
      itemCount: items.length,
      itemBuilder: (context, i) => items[i],
    );
  }
}
