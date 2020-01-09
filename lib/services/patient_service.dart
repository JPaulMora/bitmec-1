import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:bitmec/models.dart';

class PatientService {
  static const url = 'https://bitmec.herokuapp.com/api/patients/';

  static Future<List<Patient>> fetchAll() async {
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw 'StatusCode is not 200 in PatientService.fetchAll method';
    }

    List body = jsonDecode(response.body);

    return body.map((p) => Patient.fromJson(p)).toList();
  }
}
