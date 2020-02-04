import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:bitmec/models.dart';

class HabitService {
  static const url = 'http://bitmec.herokuapp.com/api/medical_history/habit/';

  static Future<Habit> create(Habit habit) async {
    final response = await http.post(url,
      body: jsonEncode(habit.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 201) {
      throw response.body;
    }

    final responseUTF8 = utf8.decode(response.bodyBytes);
    final body = jsonDecode(responseUTF8);

    return Habit.fromJson(body);
  }

  static Future<Habit> update(Habit habit) async {
    final response = await http.patch('$url${habit.id}/',
      body: jsonEncode(habit.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw response.body;
    }

    final responseUTF8 = utf8.decode(response.bodyBytes);
    final body = jsonDecode(responseUTF8);

    return Habit.fromJson(body);
  }

  static Future remove(int id) async {
    final response = await http.delete('$url$id/');

    if (response.statusCode != 204) {
      throw response.body;
    }
  }
}
