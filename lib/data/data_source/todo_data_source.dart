import 'dart:developer';
// import 'package:dio/dio.dart';
import 'package:todo_app_2/core/constants/contants.dart';
import 'package:todo_app_2/core/error/exception.dart';
import 'package:todo_app_2/data/model/todo_model.dart';
import 'package:todo_app_2/domain/usecases/get_todo.dart';
import 'package:http/http.dart' as http;

abstract class TodoDataSource {
  Future<http.Response> getTodo(TodoRequest request);
}

class TodoDataSourceImpl extends TodoDataSource {
  final http.Client client;
  TodoDataSourceImpl({required this.client});

  @override
  Future<http.Response> getTodo(TodoRequest request) async {
    // var path = '${Urls.baseUrl}/todo-list';
    var qurey = {
      "offset": "${request.offset ?? 0}",
      "limit": "${request.limit ?? 10}",
      "sortBy": request.sort ?? "createdAt",
      "isAsc": "${request.asc ?? true}",
      "status": request.status,
    };
    Uri path = Uri.https("${Urls.baseUrl}", "/todo-list", qurey);
    log("url : $path");
    log("qurey : $qurey");
    http.Response source = await client.get(path);
    return source;
  }
}
