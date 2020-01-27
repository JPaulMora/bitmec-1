import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:bitmec/models.dart';

class AppointmentService {
  static const url = 'http://bitmec.herokuapp.com/api/appointments/';

  static Future<List<Appointment>> fetchAll() async {
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw response.body;
    }

    List body = jsonDecode(response.body);
    return body.map((a) => Appointment.fromJson(a)).toList();
  }

  static Future<Appointment> create(Appointment obj) async {
    final response = await http.post(url,
      body: jsonEncode(obj.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 201) {
      throw response.body;
    }

    final body = jsonDecode(response.body);
    return Appointment.fromJson(body);
  }

  static Future<Appointment> update(Appointment obj) async {
    final response = await http.patch('$url${obj.id}/',
      body: jsonEncode(obj.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw response.body;
    }

    final body = jsonDecode(response.body);
    return Appointment.fromJson(body);
  }

  static Future remove(int id) async {
    final response = await http.delete('$url$id/');

    if (response.statusCode != 204) {
      throw response.body;
    }
  }
}
