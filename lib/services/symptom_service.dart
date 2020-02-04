import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:bitmec/models.dart';

class SymptomService {
  static const url = 'http://bitmec.herokuapp.com/api/consultations/symptom/';

  static Future<Symptom> create(Symptom symptom) async {
    final response = await http.post(url,
      body: jsonEncode(symptom.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 201) {
      throw response.body;
    }

    final responseUTF8 = utf8.decode(response.bodyBytes);
    final body = jsonDecode(responseUTF8);

    return Symptom.fromJson(body);
  }

  static Future<Symptom> update(Symptom symptom) async {
    final response = await http.patch('$url${symptom.id}/',
      body: jsonEncode(symptom.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw response.body;
    }

    final responseUTF8 = utf8.decode(response.bodyBytes);
    final body = jsonDecode(responseUTF8);

    return Symptom.fromJson(body);
  }

  static Future<void> remove(int id) async {
    final response = await http.delete('$url$id/');

    if (response.statusCode != 204) {
      throw response.body;
    }
  }
}
