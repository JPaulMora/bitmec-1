import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:bitmec/models.dart';

class MedicalPrescriptionService {
  static const url = 'http://bitmec.herokuapp.com/api/medical_history/historical_prescription/';

  static Future<Prescription> create(Prescription prescription) async {
    final response = await http.post(url,
      body: jsonEncode(prescription.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 201) {
      throw response.body;
    }

    final responseUTF8 = utf8.decode(response.bodyBytes);
    final body = jsonDecode(responseUTF8);

    return Prescription.fromJson(body);
  }

  static Future<Prescription> update(Prescription prescription) async {
    final response = await http.patch('$url${prescription.id}/',
      body: jsonEncode(prescription.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw response.body;
    }

    final responseUTF8 = utf8.decode(response.bodyBytes);
    final body = jsonDecode(responseUTF8);

    return Prescription.fromJson(body);
  }

  static Future remove(int id) async {
    final response = await http.delete('$url$id/');

    if (response.statusCode != 204) {
      throw response.body;
    }
  }
}
