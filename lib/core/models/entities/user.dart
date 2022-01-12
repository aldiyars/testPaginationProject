import 'dart:convert';

import 'package:hive/hive.dart';

import 'base_entity.dart';
part 'user.g.dart';

///Что ты работать и сохранить с этой объектой локально сделал и храню в HiveNoSql
///Специально тестовый RESTApi создал для тестового проекта
///UserAdapter его генерированный класс который поможет работат с Hive
@HiveType(typeId: 1)
class User extends BaseEntity {
  User({
    this.createdAt,
    this.name,
    this.avatar,
    this.deletedAt,
    this.isActive,
    this.id,
    this.img,
  }) : super(createdAt: createdAt, deletedAt: deletedAt, isActive: isActive, id: id);

  @override
  @HiveField(1)
  DateTime? createdAt;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? avatar;
  @override
  @HiveField(4)
  DateTime? deletedAt;
  @override
  @HiveField(5)
  bool? isActive;
  String? img;
  @override
  @HiveField(6)
  String? id;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        createdAt: DateTime.parse(json["createdAt"]),
        name: json["name"],
        avatar: json["avatar"],
        deletedAt: DateTime.parse(json["deletedAt"]),
        isActive: json["isActive"],
        id: json["id"],
        img: json['img'],
      );

  Map<String, dynamic> toMap() => {
        "createdAt": createdAt!.toIso8601String(),
        "name": name,
        "avatar": avatar,
        "deletedAt": deletedAt!.toIso8601String(),
        "isActive": isActive,
        "id": id,
      };
}
