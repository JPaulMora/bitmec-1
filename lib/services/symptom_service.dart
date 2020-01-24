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
      print(response.body);
      throw 'StatusCode is not 201 in SymptomService.create method';
    }

    final body = jsonDecode(response.body);
    return Symptom.fromJson(body);
  }
}
