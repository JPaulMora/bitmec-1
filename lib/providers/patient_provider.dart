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
  set dataLoaded(bool value) {
    _dataLoaded = value;
    notifyListeners();
  }

  Patient _object;
  Patient get object => _object;

  bool _objectLoaded = false;
  bool get objectLoaded => _objectLoaded;
  set objectLoaded(bool value) {
    _objectLoaded = value;
    notifyListeners();
  }

  void removeObject() {
    _object = null;
    _objectLoaded = false;
  }

  static PatientProvider of(BuildContext context) => Provider.of(context);

  void fetchAll([Function(List<Patient>) callback]) {
    PatientService.fetchAll().then((response) {
      _data = response;

      _data.sort((a, b) {
        final aName = '${a.firstName} ${a.lastName}'.toLowerCase();
        final bName = '${b.firstName} ${b.lastName}'.toLowerCase();

        return aName.compareTo(bName);
      });

      _dataLoaded = true;
      notifyListeners();

      if (callback != null) {
        callback(response);
      }
    });
  }

  void fetchById(int id, [Function(Patient) callback]) {
    PatientService.fetchById(id).then((response) {
      _object = response;
      _objectLoaded = true;
      notifyListeners();

      if (callback != null) {
        callback(response);
      }
    });
  }

  void addConsultation(Consultation consultation) {
    object.consultations.add(consultation);
    notifyListeners();
  }
}
