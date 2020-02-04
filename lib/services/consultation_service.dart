import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:bitmec/models.dart';

class ConsultationService {
  static const url = 'https://bitmec.herokuapp.com/api/consultations/';

  static Future<Consultation> fetchById(int id) async {
    final response = await http.get('$url$id');

    if (response.statusCode != 200) {
      throw response.body;
    }

    final responseUTF8 = utf8.decode(response.bodyBytes);
    final body = jsonDecode(responseUTF8);

    return Consultation.fromJson(body);
  }

  static Future<Consultation> create(Consultation consultation) async {
    final response = await http.post(url,
      body: jsonEncode(consultation.toJson()),
      headers: { 'Content-Type': 'application/json' },
    );

    if (response.statusCode != 201) {
      throw response.body;
    }

    final responseUTF8 = utf8.decode(response.bodyBytes);
    final body = jsonDecode(responseUTF8);

    return Consultation.fromJson(body);
  }
}
