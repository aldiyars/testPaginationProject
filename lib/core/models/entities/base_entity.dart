import 'package:hive/hive.dart';

///Базовый сущносить(model) который все сущность от сюда наследуеть
abstract class BaseEntity extends HiveObject {
  BaseEntity({
    this.createdAt,
    this.deletedAt,
    this.isActive,
    this.id,
  });

  DateTime? createdAt;
  DateTime? deletedAt;
  bool? isActive;
  String? id;
}
