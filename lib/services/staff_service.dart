import 'dart:convert';

import 'package:http/http.dart' as http;

class StaffService {
  static const url = 'http://bitmec.herokuapp.com/api/staff/login/';

  static Future<http.Response> login(Map data) async {
    final response = await http.post(url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    return response;
  }
}
