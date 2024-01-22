import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app_2/core/constants/contants.dart';
import 'package:todo_app_2/data/data_source/todo_data_source.dart';
import 'package:todo_app_2/domain/usecases/get_todo.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements Client {}

class MockResponse extends Mock implements Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('UserRemoteDataSource', () {
    // setupLocator();

    late MockClient mockHttpClient;
    late TodoDataSourceImpl todoDataSourceImpl;
    late String baseUrl;
    setUp(() {
      mockHttpClient = MockClient();
      todoDataSourceImpl = TodoDataSourceImpl(client: mockHttpClient);
      baseUrl = Urls.baseUrl;
    });

    group('todo get', () {
      test('when call api', () async {
        final request = TodoRequest('TODO');
        var qurey = {
          "offset": "${request.offset ?? 0}",
          "limit": "${request.limit ?? 10}",
          "sortBy": request.sort ?? "createdAt",
          "isAsc": "${request.asc ?? true}",
          "status": request.status,
        };
        Uri path = Uri.https(baseUrl, "/todo-list", qurey);
        when(() => mockHttpClient.get(path))
            .thenAnswer((_) async => Response("", 200));
        final result = await todoDataSourceImpl.getTodo(request);
        expect(result.statusCode, 200);
      });
    });
  });
}
