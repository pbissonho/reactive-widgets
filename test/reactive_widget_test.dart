import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_widgets/reactive_widgets.dart';

void main() {
  testWidgets("Reactive Builder - When stream receive a data ", (tester) async {
    StreamController<String> _controller = StreamController<String>();

    var widget = ReactiveBuilder<String>(
      stream: _controller.stream,
      builder: (_, data) => MaterialApp(home: Text(data)),
    );

    _controller.add("Hello");
    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final textFinder = find.text('Hello');

    expect(textFinder, findsOneWidget);

    _controller.close();
  });

  testWidgets("Reactive Builder - When ReactiveBuilder not receive any data",
      (tester) async {
    StreamController<String> _controller = StreamController<String>();

    var widget = ReactiveBuilder<String>(
      stream: _controller.stream,
      builder: (_, data) => MaterialApp(home: Text(data)),
    );

    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final textFinder = find.byType(CircularProgressIndicator);

    expect(textFinder, findsOneWidget);

    _controller.close();
  });

  testWidgets("Reactive Builder - When ReactiveBuilder not receive any data",
      (tester) async {
    StreamController<String> _controller = StreamController<String>();

    var widget = MaterialApp(
        home: ReactiveBuilder<String>(
      stream: _controller.stream,
      builder: (_, data) => Text(data),
      emptyBuilder: () => Container(
        child: Text("Loading"),
      ),
    ));

    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final textFinder = find.widgetWithText(Container, "Loading");

    expect(textFinder, findsOneWidget);

    _controller.close();
  });

  testWidgets("Reactive Builder - When ReactiveBuilder receive a erro",
      (tester) async {
    StreamController<String> _controller = StreamController<String>();

    var widget = MaterialApp(
        home: ReactiveBuilder<String>(
      stream: _controller.stream,
      builder: (_, data) => Text(data),
    ));

    _controller.addError("Error");
    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final textFinder = find.text("Error");

    expect(textFinder, findsOneWidget);

    _controller.close();
  });

  testWidgets("Reactive Builder - When ReactiveBuilder receive a erro",
      (tester) async {
    StreamController<String> _controller = StreamController<String>();

    var widget = MaterialApp(
        home: ReactiveBuilder<String>(
      stream: _controller.stream,
      builder: (_, data) => Text(data),
      errorBuilder: (error) => Text(error),
    ));

    _controller.addError("Custom Error");
    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final textFinder = find.text("Custom Error");

    expect(textFinder, findsOneWidget);

    _controller.close();
  });
}
