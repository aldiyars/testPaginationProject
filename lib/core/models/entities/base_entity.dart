abstract class BaseEntity {
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
