import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

import 'package:bitmec/models.dart';
import 'package:bitmec/services.dart';

class PatientProvider with ChangeNotifier {
  List<Patient> _data = [];
  List<Patient> get data => _data;

  bool _dataLoaded = false;
  bool get dataLoaded => _dataLoaded;

  static PatientProvider of(BuildContext context) => Provider.of(context);

  void fetchAll([Function(List<Patient>) callback]) {
    PatientService.fetchAll().then((response) {
      _data = response;
      _dataLoaded = true;
      notifyListeners();

      if (callback != null) {
        callback(response);
      }
    });
  }
}
