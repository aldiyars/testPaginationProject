import 'dart:convert';

import 'base_entity.dart';

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
  DateTime? createdAt;
  String? name;
  String? avatar;
  @override
  DateTime? deletedAt;
  @override
  bool? isActive;
  String? img;
  @override
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
