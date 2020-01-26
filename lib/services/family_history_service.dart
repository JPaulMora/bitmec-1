import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:bitmec/models.dart';

class FamilyHistoryService {
  static const url = 'http://bitmec.herokuapp.com/api/medical_history/family_member_condition/';

  static Future<FamilyMemberCondition> create(FamilyMemberCondition member) async {
    final response = await http.post(url,
      body: jsonEncode(member.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 201) {
      throw response.body;
    }

    final body = jsonDecode(response.body);
    return FamilyMemberCondition.fromJson(body);
  }

  static Future<FamilyMemberCondition> update(FamilyMemberCondition member) async {
    final response = await http.patch('$url${member.id}/',
      body: jsonEncode(member.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw response.body;
    }

    final body = jsonDecode(response.body);
    return FamilyMemberCondition.fromJson(body);
  }

  static Future<void> remove(int id) async {
    final response = await http.delete('$url$id/');

    if (response.statusCode != 204) {
      throw response.body;
    }
  }
}
