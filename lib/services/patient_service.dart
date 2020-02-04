import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:bitmec/models.dart';

class PatientService {
  static const url = 'https://bitmec.herokuapp.com/api/patients/';

  static Future<List<Patient>> fetchAll() async {
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw response.body;
    }

    String responseUTF8 = utf8.decode(response.bodyBytes);
    List body = jsonDecode(responseUTF8);

    return body.map((p) => Patient.fromJson(p)).toList();
  }

  static Future<Patient> fetchById(int id) async {
    final response = await http.get('$url$id');

    if (response.statusCode != 200) {
      throw response.body;
    }

    final responseUTF8 = utf8.decode(response.bodyBytes);
    final body = jsonDecode(responseUTF8);

    return Patient.fromJson(body);
  }

  static Future<Patient> update(Patient obj) async {
    final response = await http.patch('$url${obj.id}/');

    if (response.statusCode != 200) {
      throw response.body;
    }

    final body = jsonDecode(response.body);
    return Patient.fromJson(body);
  }
}
