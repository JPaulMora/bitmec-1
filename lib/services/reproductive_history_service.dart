import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:bitmec/models.dart';

class ReproductiveHistoryService {
  static const url = 'http://bitmec.herokuapp.com/api/medical_history/reproductive_history/';

  static Future<ReproductiveHistory> create(ReproductiveHistory reproductiveHistory) async {
    final response = await http.post(url,
      body: jsonEncode(reproductiveHistory.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 201) {
      throw response.body;
    }

    final body = jsonDecode(response.body);
    return ReproductiveHistory.fromJson(body);
  }

  static Future<ReproductiveHistory> update(ReproductiveHistory reproductiveHistory) async {
    final response = await http.patch('$url${reproductiveHistory.id}/',
      body: jsonEncode(reproductiveHistory.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw response.body;
    }

    final body = jsonDecode(response.body);
    return ReproductiveHistory.fromJson(body);
  }

  static Future remove(int id) async {
    final response = await http.delete('$url$id/');

    if (response.statusCode != 204) {
      throw response.body;
    }
  }
}
