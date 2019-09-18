import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_widgets/reactive_widgets.dart';

abstract class TestState {
  String get name;
}

class AdminState extends TestState {
  @override
  String get name => "AdminState";
}

class UserState extends TestState {
  @override
  String get name => "UserState";
}

class Undefined extends TestState {
  @override
  String get name => "Not";
}

void main() {
  testWidgets("ReactiveText - When have data", (tester) async {
    StreamController<TestState> _controller = StreamController<TestState>();

    var widget = MaterialApp(
        home: ReactiveStat<TestState>(
      stream: _controller.stream,
      builders: [
        BuilderState<AdminState>(builder: (_, data) => Text(data.name)),
        BuilderState<UserState>(builder: (_, data) => Text("State"))
      ],
    ));

    _controller.add(AdminState());
    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final textFinder = find.text("AdminState");

    expect(textFinder, findsOneWidget);

    _controller.close();
  });

  testWidgets("ReactiveText - when a type not is defined", (tester) async {
    StreamController<TestState> _controller = StreamController<TestState>();
    String message;

    var widget = MaterialApp(
        home: ReactiveStat<TestState>(
      stream: _controller.stream,
      builders: [
        BuilderState<AdminState>(builder: (_, data) => Text(data.name)),
        BuilderState<UserState>(builder: (_, data) => Text("State"))
      ],
    ));

    _controller.add(Undefined());
    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    var exception = tester.takeException();
    message = exception.toString();
    expect("Exception: Not have BuilderState for type Undefined", message);

    _controller.close();
  });
}
