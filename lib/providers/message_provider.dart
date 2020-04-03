import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

import 'package:bitmec/models.dart';
import 'package:bitmec/services.dart';

class MessageProvider with ChangeNotifier {
  List<dynamic> _data = [];
  List<dynamic> get data {
    _data.sort((a, b) {
      final dA = DateTime.parse(a is Message ? a.timestamp : a['timestamp']);
      final dB = DateTime.parse(b is Message ? b.timestamp : b['timestamp']);
      return dA.compareTo(dB);
    });

    return _data;
  }

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

  void fetchAll(int consultationId, [Function(List<dynamic>) callback]) {
    MessageService.fetchAll(consultationId).then((response) {
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

      if (callback != null) callback(response);
    });
  }

  void sendImage(Map msg, [Function(Map) callback]) {
    MessageService.sendImage(msg).then((response) {
      _data.add(response);
      notifyListeners();

      if (callback != null) callback(response);
    });
  }
}
