import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:bitmec/models.dart';

class BirthControlService {
  static const url = 'http://bitmec.herokuapp.com/api/medical_history/birth_control/';

  static Future<BirthControl> create(BirthControl contraceptive) async {
    final response = await http.post(url,
      body: jsonEncode(contraceptive.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 201) {
      throw response.body;
    }

    final body = jsonDecode(response.body);
    return BirthControl.fromJson(body);
  }

  static Future<BirthControl> update(BirthControl contraceptive) async {
    final response = await http.patch('$url${contraceptive.id}/',
      body: jsonEncode(contraceptive.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw response.body;
    }

    final body = jsonDecode(response.body);
    return BirthControl.fromJson(body);
  }

  static Future<void> remove(int id) async {
    final response = await http.delete('$url$id/');

    if (response.statusCode != 204) {
      throw response.body;
    }
  }
}
