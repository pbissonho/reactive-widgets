import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_widgets/reactive_widgets.dart';

void main() {
  testWidgets("ReactiveListView", (tester) async {
    StreamController<List<String>> _controller =
        StreamController<List<String>>();

    var widget = MaterialApp(
        home: ReactiveListView(
      stream: _controller.stream,
      itemBuilder: (BuildContext context, String itemData) {
        return Text(itemData);
      },
    ));

    _controller.add(["Item1", "Item2", "Item3"]);
    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final textFinder = find.text("Item1");
    final textFinder2 = find.text("Item2");
    final textFinder3 = find.text("Item3");

    expect(textFinder, findsOneWidget);
    expect(textFinder2, findsOneWidget);
    expect(textFinder3, findsOneWidget);

    _controller.close();
  });

  testWidgets(" When use separatorBuilder", (tester) async {
    StreamController<List<String>> _controller =
        StreamController<List<String>>();

    var widget = MaterialApp(
        home: ReactiveListView(
      stream: _controller.stream,
      itemBuilder: (BuildContext context, String itemData) {
        return Text(itemData);
      },
      separatorBuilder: Icon(Icons.face),
    ));

    _controller.add(["Item1", "Item2"]);
    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final textFinder = find.byIcon(Icons.face);

    expect(textFinder, findsOneWidget);

    _controller.close();
  });
}
