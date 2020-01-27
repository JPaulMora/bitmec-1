import 'package:json_annotation/json_annotation.dart';

import 'package:bitmec/models.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  int id;
  String message;
  String timestamp;
  Doctor doctor;
  Ambassador ambassador;
  Consultation consultation;

  Message({
    this.id,
    this.message,
    this.timestamp,
    this.doctor,
    this.ambassador,
    this.consultation,
  });

  factory Message.fromJson(Map json) => _$MessageFromJson(json);

  Map toJson() => _$MessageToJson(this);
}
