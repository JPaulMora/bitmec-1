import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:bitmec/models.dart';
import 'package:bitmec/services.dart';

class FamilyHistoryProvider with ChangeNotifier {
  static FamilyHistoryProvider of(context) => Provider.of(context);

  void create(FamilyMemberCondition member,
      [Function(FamilyMemberCondition) callback]) {
    FamilyHistoryService.create(member).then((response) {
      if (callback != null)
        callback(response);
    });
  }

  void update(FamilyMemberCondition member,
      [Function(FamilyMemberCondition) callback]) {
    FamilyHistoryService.update(member).then((response) {
      if (callback != null)
        callback(response);
    });
  }

  void remove(int id, [Function(int) callback]) {
    FamilyHistoryService.remove(id).then((_) {
      if (callback != null)
        callback(id);
    });
  }
}
