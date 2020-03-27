import 'dart:convert';

import 'package:bitmec/models.dart';
import 'package:bitmec/services.dart';
import 'package:http/http.dart' as http;

class MessageService {
  static const url = 'http://bitmec.herokuapp.com/api/consultations/message/';

  static Future<List<Message>> fetchAll() async {
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw response.body;
    }

    final responseUTF8 = utf8.decode(response.bodyBytes);
    List body = jsonDecode(responseUTF8);

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

    final responseUTF8 = utf8.decode(response.bodyBytes);
    final body = jsonDecode(responseUTF8);

    Message msg = await fetchById(Message.fromJson(body).id);
    return msg;
  }

  static Future<Message> fetchById(int id) async {
    final response = await http.get('$url$id');

    if (response.statusCode != 200) {
      throw response.body;
    }

    final responseUTF8 = utf8.decode(response.bodyBytes);
    final body = jsonDecode(responseUTF8);
    return Message.fromJson(body);
  }
}
