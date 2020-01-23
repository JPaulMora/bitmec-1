import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:bitmec/models.dart';

class ConsultationService {
  static const url = 'https://bitmec.herokuapp.com/api/consultations/';

  static Future<Consultation> create(Consultation consultation) async {
    final response = await http.post(url,
      body: jsonEncode(consultation.toJson()),
      headers: { 'Content-Type': 'application/json' },
    );

    if (response.statusCode != 201) {
      throw 'StatusCode is not 201 in ConsultationService.create method';
    }

    final body = jsonDecode(response.body);
    return Consultation.fromJson(body);
  }
}
