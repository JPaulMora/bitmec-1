import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

import 'package:bitmec/models.dart';
import 'package:bitmec/services.dart';

class MessageProvider with ChangeNotifier {
  List<Message> _data = [];
  List<Message> get data => _data;

  bool _dataLoaded = false;
  bool get dataLoaded => _dataLoaded;
  set dataLoaded(bool value) {
    _dataLoaded = value;
    notifyListeners();
  }

  void removeData() {
    _data = [];
    _dataLoaded = false;
  }

  static MessageProvider of(BuildContext context) => Provider.of(context);

  void fetchAll([Function(List<Message>) callback]) {
    MessageService.fetchAll().then((response) {
      _data = response;
      _dataLoaded = true;
      notifyListeners();

      if (callback != null) {
        callback(response);
      }
    });
  }

  void create(Message obj, [Function(Message) callback]) {
    MessageService.create(obj).then((response) {
      _data.add(response);
      notifyListeners();

      if (callback != null)
        callback(response);
    });
  }
}
