import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

import 'package:bitmec/models.dart';

class MessageService {
  static const url = 'http://bitmec.herokuapp.com/api/consultations/message/';

  static Future<List<dynamic>> fetchAll() async {
    final response = await http.get('$url');
    if (response.statusCode != 200) throw response.body;
    final responseUTF8 = utf8.decode(response.bodyBytes);
    List body = jsonDecode(responseUTF8);
    final messages = body.map((json) => Message.fromJson(json)).toList();

    final responseImg = await http.get('http://bitmec.herokuapp.com/api/consultations/image/');
    if (responseImg.statusCode != 200) throw responseImg.body;
    final responseUTF8Img = utf8.decode(responseImg.bodyBytes);
    List bodyImg = jsonDecode(responseUTF8Img);
    final imgs = bodyImg.map((json) => {
      'id': json['id'],
      'image': json['image'],
      'timestamp': json['timestamp'],
    }).toList();

    return <dynamic>[]
      ..addAll(messages)
      ..addAll(imgs);
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
    final response = await http.get('$url$id/');

    if (response.statusCode != 200) {
      throw response.body;
    }

    final responseUTF8 = utf8.decode(response.bodyBytes);
    final body = jsonDecode(responseUTF8);
    return Message.fromJson(body);
  }

  static Future<Map> sendImage(Map message) async {
    Map<String, dynamic> formMap = {
      'consultation': message['consultation'],
      'image': await dio.MultipartFile.fromFile(
        message['image'].path,
        filename: message['image'].path.split('/').last,
      ),
    };

    final form = dio.FormData.fromMap(formMap);
    final response = await dio.Dio().post('http://bitmec.herokuapp.com/api/consultations/image/', data: form);
    if (response.statusCode != 201) throw response.data;
    print('Code -> ${response.data}');
    return response.data;
  }
}
