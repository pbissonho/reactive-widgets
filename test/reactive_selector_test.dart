import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_widgets/reactive_widgets.dart';

void main() {
  testWidgets("ReactiveSelector - on true", (tester) async {
    StreamController<bool> _controller = StreamController<bool>();

    var widget = MaterialApp(
        home: ReactiveSelector(
      stream: _controller.stream,
      onfalse: Text("FALSE"),
      ontrue: Text("TRUE"),
    ));

    _controller.add(true);
    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final textFinder = find.text("TRUE");

    expect(textFinder, findsOneWidget);

    _controller.close();
  });

  testWidgets("ReactiveSelector - on false", (tester) async {
    StreamController<bool> _controller = StreamController<bool>();

    var widget = MaterialApp(
        home: ReactiveSelector(
      stream: _controller.stream,
      onfalse: Text("FALSE"),
      ontrue: Text("TRUE"),
    ));

    _controller.add(false);
    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final textFinder = find.text("FALSE");

    expect(textFinder, findsOneWidget);

    _controller.close();
  });

  testWidgets("ReactiveSelectorBuilder - on true", (tester) async {
    StreamController<bool> _controller = StreamController<bool>();

    var widget = MaterialApp(
        home: ReactiveSelectorBuilder(
      stream: _controller.stream,
      trueBuilder: (_) => Text("TRUE"),
      falseBuilder: (_) => Text("FALSE"),
    ));

    _controller.add(true);
    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final textFinder = find.text("TRUE");

    expect(textFinder, findsOneWidget);

    _controller.close();
  });

  testWidgets("ReactiveSelectorBuilder - on false", (tester) async {
    StreamController<bool> _controller = StreamController<bool>();

    var widget = MaterialApp(
        home: ReactiveSelectorBuilder(
      stream: _controller.stream,
      trueBuilder: (_) => Text("TRUE"),
      falseBuilder: (_) => Text("FALSE"),
    ));

    _controller.add(false);
    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final textFinder = find.text("FALSE");

    expect(textFinder, findsOneWidget);

    _controller.close();
  });
}
