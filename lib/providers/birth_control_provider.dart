import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:bitmec/models.dart';
import 'package:bitmec/services.dart';

class BirthControlProvider with ChangeNotifier {
  static BirthControlProvider of(context) => Provider.of(context);

  void create(BirthControl contraceptive, [Function(BirthControl) callback]) {
    BirthControlService.create(contraceptive).then((response) {
      if (callback != null)
        callback(response);
    });
  }

  void update(BirthControl contraceptive, [Function(BirthControl) callback]) {
    BirthControlService.update(contraceptive).then((response) {
      if (callback != null)
        callback(response);
    });
  }

  void remove(int id, [Function(int) callback]) {
    BirthControlService.remove(id).then((_) {
      if (callback != null)
        callback(id);
    });
  }
}
