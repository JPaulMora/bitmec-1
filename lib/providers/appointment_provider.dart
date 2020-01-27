import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

import 'package:bitmec/models.dart';
import 'package:bitmec/services.dart';

class AppointmentProvider with ChangeNotifier {
  List<Appointment> _data = [];
  List<Appointment> get data => _data;

  bool _dataLoaded = false;
  bool get dataLoaded => _dataLoaded;
  set dataLoaded(bool value) {
    _dataLoaded = value;
    notifyListeners();
  }

  static AppointmentProvider of(BuildContext context) => Provider.of(context);

  void fetchAll([Function(List<Appointment>) callback]) {
    AppointmentService.fetchAll().then((response) {
      _data = response;
      _dataLoaded = true;
      notifyListeners();

      if (callback != null) {
        callback(response);
      }
    });
  }
}
