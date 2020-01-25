import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:bitmec/models.dart';
import 'package:bitmec/services.dart';

class MedicalPrescriptionProvider with ChangeNotifier {
  static MedicalPrescriptionProvider of(context) =>
      Provider.of(context);

  void create(Prescription prescription, [Function(Prescription) callback]) {
    MedicalPrescriptionService.create(prescription).then((response) {
      if (callback != null)
        callback(response);
    });
  }

  void update(Prescription prescription, [Function(Prescription) callback]) {
    MedicalPrescriptionService.update(prescription).then((response) {
      if (callback != null)
        callback(response);
    });
  }

  void remove(int id, [Function(int) callback]) {
    MedicalPrescriptionService.remove(id).then((_) {
      if (callback != null)
        callback(id);
    });
  }
}
