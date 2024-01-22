// To parse this JSON data, do
//
//     final todoModel = todoModelFromJson(jsonString);

import 'dart:convert';

import 'package:todo_app_2/domain/entities/todo_entity.dart';

TodoModel todoModelFromJson(String str) => TodoModel.fromJson(json.decode(str));

String todoModelToJson(TodoModel data) => json.encode(data.toJson());

class TodoModel extends TodoEntity {
  List<Task>? tasks;
  int? pageNumber;
  int? totalPages;

  TodoModel({
    this.tasks,
    this.pageNumber,
    this.totalPages,
  });

  TodoEntity toEntity({
    List<Task>? tasks,
    int? pageNumber,
    int? totalPages,
  }) =>
      TodoEntity(
        tasks: tasks ?? this.tasks,
        pageNumber: pageNumber ?? this.pageNumber,
        totalPages: totalPages ?? this.totalPages,
      );

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        tasks: json["tasks"] == null
            ? []
            : List<Task>.from(json["tasks"]!.map((x) => Task.fromJson(x))),
        pageNumber: json["pageNumber"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "tasks": tasks == null
            ? []
            : List<dynamic>.from(tasks!.map((x) => x.toJson())),
        "pageNumber": pageNumber,
        "totalPages": totalPages,
      };
}

class Task extends TaskEntity {
  String? id;
  String? title;
  String? description;
  DateTime? createdAt;
  String? status;

  Task({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.status,
  });

  TaskEntity toEntity({
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

  factory Task.fromJson(Map<String, dynamic> json) => Task(
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
