import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:bitmec/models.dart';

class ImageDBService {
  static const baseURL = 'http://bitmec.herokuapp.com/api/';

  static Future<dynamic> create(int urlID, File file, int referenceID) async {
    String url;
    String fieldName;

    switch (urlID) {
      case 0:
        fieldName = 'historical_condition';
        url = '${baseURL}medical_history/historical_condition_document/';
        break;

      default:
        throw 'URL Identifier not exits';
    }

    Map<String, dynamic> formMap = {
      fieldName: referenceID,
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    };

    final form = FormData.fromMap(formMap);
    final response = await Dio().post(url, data: form);

    if (response.statusCode != 201) {
      throw response.data;
    }

    return ImageDB.fromJson(response.data);
  }
}
