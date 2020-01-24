import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:bitmec/models.dart';
import 'package:bitmec/services.dart';

class SymptomProvider with ChangeNotifier {
  static SymptomProvider of(context) => Provider.of(context);

  void create(Symptom symptom, [Function(Symptom) callback]) {
    SymptomService.create(symptom).then((response) {
      if (callback != null)
        callback(response);
    });
  }

  void update(Symptom symptom, [Function(Symptom) callback]) {
    SymptomService.update(symptom).then((response) {
      if (callback != null)
        callback(response);
    });
  }

  void remove(int id, [Function(int) callback]) {
    SymptomService.remove(id).then((_) {
      if (callback != null)
        callback(id);
    });
  }
}
