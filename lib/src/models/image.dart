import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class Image extends HiveObject {
  @JsonKey(name: '_id')
  @HiveField(0)
  String id;
  @JsonKey(name: 'image')
  @HiveField(1)
  String image;

  Image({this.id, this.image});

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}