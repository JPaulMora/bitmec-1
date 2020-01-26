import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:bitmec/models.dart';
import 'package:bitmec/services.dart';

class MedicalConditionProvider with ChangeNotifier {
  static MedicalConditionProvider of(context) => Provider.of(context);

  void create(MedicalCondition medicalCondition,
      [Function(MedicalCondition) callback]) {
    MedicalConditionService.create(medicalCondition).then((response) {
      if (callback != null)
        callback(response);
    });
  }

  void update(MedicalCondition medicalCondition,
      [Function(MedicalCondition) callback]) {
    MedicalConditionService.update(medicalCondition).then((response) {
      if (callback != null)
        callback(response);
    });
  }

  void remove(int id, [Function(int) callback]) {
    MedicalConditionService.remove(id).then((_) {
      if (callback != null)
        callback(id);
    });
  }
}
