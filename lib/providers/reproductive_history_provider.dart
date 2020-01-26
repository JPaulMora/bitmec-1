import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:bitmec/models.dart';
import 'package:bitmec/services.dart';

class ReproductiveHistoryProvider with ChangeNotifier {
  static ReproductiveHistoryProvider of(context) =>
      Provider.of(context);

  void create(ReproductiveHistory reproductiveHistory,
      [Function(ReproductiveHistory) callback]) {
    ReproductiveHistoryService.create(reproductiveHistory).then((response) {
      if (callback != null)
        callback(response);
    });
  }

  void update(ReproductiveHistory reproductiveHistory,
      [Function(ReproductiveHistory) callback]) {
    ReproductiveHistoryService.update(reproductiveHistory).then((response) {
      if (callback != null)
        callback(response);
    });
  }

  void remove(int id, [Function(int) callback]) {
    ReproductiveHistoryService.remove(id).then((_) {
      if (callback != null)
        callback(id);
    });
  }
}
