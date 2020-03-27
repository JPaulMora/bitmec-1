import 'dart:convert';

import 'package:bitmec/models.dart';
import 'package:http/http.dart' as http;

class AmbassadorService {
  static const url = 'http://bitmec.herokuapp.com/api/staff/ambassadors/';

  static Future<Ambassador> fetchById(int id) async {
    final response = await http.get('$url$id');

    if (response.statusCode != 200) {
      throw response.body;
    }

    final responseUTF8 = utf8.decode(response.bodyBytes);
    final body = jsonDecode(responseUTF8);
    return Ambassador.fromJson(body);
  }
}
