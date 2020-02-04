import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:bitmec/models.dart';

class MedicalSurgeryService {
  static const url = 'http://bitmec.herokuapp.com/api/medical_history/historical_operation/';

  static Future<Surgery> create(Surgery surgery) async {
    final response = await http.post(url,
      body: jsonEncode(surgery.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 201) {
      throw response.body;
    }

    final responseUTF8 = utf8.decode(response.bodyBytes);
    final body = jsonDecode(responseUTF8);

    return Surgery.fromJson(body);
  }

  static Future<Surgery> update(Surgery surgery) async {
    final response = await http.patch('$url${surgery.id}/',
      body: jsonEncode(surgery.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw response.body;
    }

    final responseUTF8 = utf8.decode(response.bodyBytes);
    final body = jsonDecode(responseUTF8);

    return Surgery.fromJson(body);
  }

  static Future remove(int id) async {
    final response = await http.delete('$url$id/');

    if (response.statusCode != 204) {
      throw response.body;
    }
  }
}
