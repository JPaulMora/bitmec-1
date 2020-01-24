import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:bitmec/models.dart';
import 'package:bitmec/services.dart';

class ConsultationProvider with ChangeNotifier {
  Consultation _object;
  Consultation get object => _object;

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

  static ConsultationProvider of(BuildContext context) => Provider.of(context);

  void fetchById(int id, [Function(Consultation) callback]) {
    ConsultationService.fetchById(id).then((response) {
      _object = response;
      _objectLoaded = true;
      notifyListeners();

      if (callback != null) {
        callback(response);
      }
    });
  }

  void create(Consultation consultation, [Function(Consultation) callback]) {
    ConsultationService.create(consultation).then((c) {
      if (callback != null) {
        callback(c);
      }
    });
  }

  void addVitalSign(VitalSign vitalSign) {
    _object.vitalSigns.add(vitalSign);
    notifyListeners();
  }

  void updateVitalSign(VitalSign vitalSign) {
    final index = _object.vitalSigns.indexWhere((e) => vitalSign.id == e.id);
    _object.vitalSigns[index] = vitalSign;
    notifyListeners();
  }

  void removeVitalSign(int id) {
    _object.vitalSigns.removeWhere((e) => id == e.id);
    notifyListeners();
  }

  void addSymptom(Symptom symptom) {
    _object.symptoms.add(symptom);
    notifyListeners();
  }

  void updateSymptom(Symptom symptom) {
    final i = _object.symptoms.indexWhere((e) => symptom.id == e.id);
    _object.symptoms[i] = symptom;
    notifyListeners();
  }

  void removeSymptom(int id) {
    _object.symptoms.removeWhere((e) => id == e.id);
    notifyListeners();
  }
}
