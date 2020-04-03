import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

import 'package:bitmec/models.dart';

class MessageService {
  static const urlMsg = 'https://bitmec.herokuapp.com/api/consultations/message/';
  static const urlImage = 'https://bitmec.herokuapp.com/api/consultations/image/';

  static Future<List<dynamic>> fetchAll(int consultation) async {
    final dioInst = dio.Dio();

    final formMsg = dio.FormData.fromMap({'current_consultation': consultation});
    final resMsg = await dioInst.post(urlMsg, data: formMsg);
    if (resMsg.statusCode != 200) throw resMsg.data;
    final messages = resMsg.data.map((json) => Message.fromJson(json)).toList();

    final formImg = dio.FormData.fromMap({'current_consultation': consultation});
    final resImage = await dioInst.post(urlImage, data: formImg);
    if (resImage.statusCode != 200) throw resImage.data;
    final images = resImage.data;

    return <dynamic>[]
      ..addAll(messages)
      ..addAll(images);
  }

  static Future<Message> create(Message message) async {
    final response = await http.post(urlMsg,
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
    final response = await http.get('$urlMsg$id/');

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
