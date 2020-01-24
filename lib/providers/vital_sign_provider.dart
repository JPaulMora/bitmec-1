import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:bitmec/models.dart';
import 'package:bitmec/services.dart';

class VitalSignProvider with ChangeNotifier {
  static VitalSignProvider of(BuildContext context) =>
      Provider.of(context);

  void create(VitalSign vitalSign, [Function(VitalSign) callback]) {
    VitalSignService.create(vitalSign).then((response) {
      if (callback != null) {
        callback(response);
      }
    });
  }

  void update(VitalSign vitalSign, [Function(VitalSign) callback]) {
    VitalSignService.update(vitalSign).then((response) {
      if (callback != null) {
        callback(response);
      }
    });
  }
}
