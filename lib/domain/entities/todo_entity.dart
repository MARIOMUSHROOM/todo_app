import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  TodoEntity({
    this.tasks,
    this.pageNumber,
    this.totalPages,
  });

  final List<TaskEntity>? tasks;
  final int? pageNumber;
  final int? totalPages;

  @override
  List<Object?> get props => [
        tasks,
        pageNumber,
        totalPages,
      ];
}

class TaskEntity {
  String? id;
  String? title;
  String? description;
  DateTime? createdAt;
  String? status;

  TaskEntity({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.status,
  });

  TaskEntity copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    String? status,
  }) =>
      TaskEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        status: status ?? this.status,
      );

  factory TaskEntity.fromJson(Map<String, dynamic> json) => TaskEntity(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "createdAt": createdAt?.toIso8601String(),
        "status": status,
      };
}
