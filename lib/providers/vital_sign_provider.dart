import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:bitmec/models.dart';
import 'package:bitmec/services.dart';

class VitalSignProvider with ChangeNotifier {
  static VitalSignProvider of(context) => Provider.of(context);

  void create(VitalSign vitalSign, [Function(VitalSign) callback]) {
    VitalSignService.create(vitalSign).then((response) {
      if (callback != null)
        callback(response);
    });
  }

  void update(VitalSign vitalSign, [Function(VitalSign) callback]) {
    VitalSignService.update(vitalSign).then((response) {
      if (callback != null) {
        callback(response);
      }
    });
  }

  void remove(int id, [Function(int) callback]) {
    VitalSignService.remove(id).then((_) {
      if (callback != null) {
        callback(id);
      }
    });
  }
}
