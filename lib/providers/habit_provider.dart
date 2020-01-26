import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:bitmec/models.dart';
import 'package:bitmec/services.dart';

class HabitProvider with ChangeNotifier {
  static HabitProvider of(context) => Provider.of(context);

  void create(Habit habit, [Function(Habit) callback]) {
    HabitService.create(habit).then((response) {
      if (callback != null)
        callback(response);
    });
  }

  void update(Habit habit, [Function(Habit) callback]) {
    HabitService.update(habit).then((response) {
      if (callback != null)
        callback(response);
    });
  }

  void remove(int id, [Function(int) callback]) {
    HabitService.remove(id).then((_) {
      if (callback != null)
        callback(id);
    });
  }
}
