import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:bitmec/models.dart';
import 'package:bitmec/services.dart';

class MedicalSurgeryProvider with ChangeNotifier {
  static MedicalSurgeryProvider of(context) =>
      Provider.of(context);

  void create(Surgery surgery, [Function(Surgery) callback]) {
    MedicalSurgeryService.create(surgery).then((response) {
      if (callback != null)
        callback(response);
    });
  }

  void update(Surgery surgery, [Function(Surgery) callback]) {
    MedicalSurgeryService.update(surgery).then((response) {
      if (callback != null)
        callback(response);
    });
  }

  void remove(int id, [Function(int) callback]) {
    MedicalSurgeryService.remove(id).then((_) {
      if (callback != null)
        callback(id);
    });
  }
}

