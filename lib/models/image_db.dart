import 'package:json_annotation/json_annotation.dart';

part 'image_db.g.dart';

@JsonSerializable()
class ImageDB {
  int id;
  String file;

  ImageDB({this.id, this.file});

  factory ImageDB.fromJson(Map<String, dynamic> json) => _$ImageDBFromJson(json);

  Map<String, dynamic> toJson() => _$ImageDBToJson(this);
}
