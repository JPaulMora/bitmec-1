import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:bitmec/models.dart';

class MedicalConditionService {
  static const url = 'http://bitmec.herokuapp.com/api/medical_history/historical_condition/';

  static Future<MedicalCondition> create(MedicalCondition condition) async {
    final response = await http.post(url,
      body: jsonEncode(condition.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 201) {
      throw response.body;
    }

    final responseUTF8 = utf8.decode(response.bodyBytes);
    final body = jsonDecode(responseUTF8);

    return MedicalCondition.fromJson(body);
  }

  static Future<MedicalCondition> update(MedicalCondition medicalCondition) async {
    final response = await http.patch('$url${medicalCondition.id}/',
      body: jsonEncode(medicalCondition.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw response.body;
    }

    final responseUTF8 = utf8.decode(response.bodyBytes);
    final body = jsonDecode(responseUTF8);

    return MedicalCondition.fromJson(body);
  }

  static Future<void> remove(int id) async {
    final response = await http.delete('$url$id/');

    if (response.statusCode != 204) {
      throw response.body;
    }
  }
}
