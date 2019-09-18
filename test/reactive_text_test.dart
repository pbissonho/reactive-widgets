import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_widgets/reactive_widgets.dart';

void main() {
  testWidgets("ReactiveText - When have data", (tester) async {
    StreamController<String> _controller = StreamController<String>();

    var widget = MaterialApp(
        home: ReactiveText(
      stream: _controller.stream,
    ));

    _controller.add("Text");
    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final textFinder = find.text("Text");

    expect(textFinder, findsOneWidget);

    _controller.close();
  });
}
