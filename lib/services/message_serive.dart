import 'dart:convert';

import 'package:bitmec/models.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;

class MessageService {
  static const url = 'http://bitmec.herokuapp.com/api/consultations/message/';

  static Future<List<Message>> fetchAll() async {
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw response.body;
    }

    List body = jsonDecode(response.body);
    return body.map((json) => Message.fromJson(json)).toList();
  }

  static Future<Message> create(Message message) async {
    final response = await http.post(url,
      body: jsonEncode(message.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 201) {
      throw response.body;
    }

    final body = jsonDecode(response.body);
    return Message.fromJson(body);
  }
}
