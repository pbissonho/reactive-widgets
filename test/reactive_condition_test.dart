import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_widgets/src/reactive_condition.dart';

void main() {
  testWidgets(" when a ConditionBuilder is build", (tester) async {
    StreamController<int> _controller = StreamController<int>();

    var widget = MaterialApp(
        home: ReactiveCondition<int>(
      stream: _controller.stream,
      builders: <ConditionBuilder<int>>[
        ConditionBuilder<int>(
          condition: ((int data) => data > 100),
          builder: (_, data) => Text("Incredible"),
        )
      ],
      defaultBuilder: (BuildContext context, int data) {
        return Text(data.toString());
      },
    ));

    _controller.add(200);
    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final textFinder = find.text("Incredible");

    expect(textFinder, findsOneWidget);

    _controller.close();
  });

  testWidgets(" when no condition satisfies", (tester) async {
    StreamController<int> _controller = StreamController<int>();

    var widget = MaterialApp(
        home: ReactiveCondition<int>(
      stream: _controller.stream,
      builders: <ConditionBuilder<int>>[
        ConditionBuilder<int>(
          condition: ((int data) => data > 100),
          builder: (_, data) => Text("Incredible"),
        )
      ],
      defaultBuilder: (BuildContext context, int data) {
        return Text("Default");
      },
    ));

    _controller.add(50);
    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final textFinder = find.text("Default");

    expect(textFinder, findsOneWidget);

    _controller.close();
  });
}
