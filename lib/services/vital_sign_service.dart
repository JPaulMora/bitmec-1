import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:bitmec/models.dart';

class VitalSignService {
  static const url = 'http://bitmec.herokuapp.com/api/consultations/vital_sign/';

  static Future<VitalSign> create(VitalSign vitalSign) async {
    final response = await http.post(url,
      body: jsonEncode(vitalSign.toJson()),
      headers: { 'Content-Type': 'application/json' },
    );

    if (response.statusCode != 201) {
      throw response.body;
    }

    final responseUTF8 = utf8.decode(response.bodyBytes);
    final body = jsonDecode(responseUTF8);

    return VitalSign.fromJson(body);
  }

  static Future<VitalSign> update(VitalSign vitalSign) async {
    final response = await http.patch('$url${vitalSign.id}/',
      body: jsonEncode(vitalSign.toJson()),
      headers: { 'Content-Type': 'application/json' },
    );

    if (response.statusCode != 200) {
      print(response.body);
      throw response.body;
    }

    final responseUTF8 = utf8.decode(response.bodyBytes);
    final body = jsonDecode(responseUTF8);

    return VitalSign.fromJson(body);
  }

  static Future<void> remove(int id) async {
    final response = await http.delete('$url$id/');

    if (response.statusCode != 204) {
      throw response.body;
    }
  }
}
