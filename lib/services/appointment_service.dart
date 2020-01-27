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
}
