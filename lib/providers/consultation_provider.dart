import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:bitmec/models.dart';
import 'package:bitmec/services.dart';

class ConsultationProvider with ChangeNotifier {
  static ConsultationProvider of(BuildContext context) => Provider.of(context);

  void create(Consultation consultation, [Function(Consultation) callback]) {
    ConsultationService.create(consultation).then((c) {
      if (callback != null) {
        callback(c);
      }
    });
  }
}
