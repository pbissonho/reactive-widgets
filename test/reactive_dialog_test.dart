import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_widgets/reactive_widgets.dart';

void main() {
  testWidgets("Reactive Dialog", (tester) async {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    StreamController<DialogData> _controller = StreamController<DialogData>();

    var widget = MaterialApp(
      home: Scaffold(
        key: scaffoldKey,
      ),
    );

    ReactiveDialog reactiveDialog = ReactiveDialog(
      scaffoldKey: scaffoldKey,
      stream: _controller.stream,
    );

    var dialogData = DialogData(
      title: "Test",
      onCancel: () {},
      onConfirme: () {},
      contentTextData: "Dialog",
    );

    await tester.pumpWidget(widget);

    _controller.add(dialogData);

    await tester.pump(Duration.zero);

    var finderAlert = find.byType(AlertDialog);

    expect(finderAlert, findsOneWidget);

    reactiveDialog.dispose();
    _controller.close();
  });
}
