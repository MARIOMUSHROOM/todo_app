import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todo_app_2/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("try click", (tester) async {
    app.main();
    print("todo view");
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5));

    print("slide view");
    await tester.pumpAndSettle();
    final cardView = find.text('Read a book ');
    await tester.drag(cardView, const Offset(-100, 0));
    await Future.delayed(const Duration(seconds: 5));
    final deleteButton = find.byKey(const Key('deletebutton'));
    await tester.tap(deleteButton);
    await Future.delayed(const Duration(seconds: 5));

    print("set scroll view");
    await tester.pumpAndSettle();
    final scrollView = find.byKey(const Key('scroll'));
    final listView = tester.widget<SingleChildScrollView>(scrollView);

    print("load more 1");
    final ctrl = listView.controller;
    await tester.drag(scrollView, Offset(0, -ctrl!.position.maxScrollExtent));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5));

    print("load more 2");
    final ctrl2 = listView.controller;
    await tester.drag(scrollView, Offset(0, -ctrl2!.position.maxScrollExtent));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5));

    print("load more 3");
    final ctrl3 = listView.controller;
    await tester.drag(scrollView, Offset(0, -ctrl3!.position.maxScrollExtent));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5));

    print("doing view");
    final textDOING = find.text('Doing');
    await tester.tap(textDOING);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5));

    print("done view");
    final textDONE = find.text('Done');
    await tester.tap(textDONE);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5));
  });
}
