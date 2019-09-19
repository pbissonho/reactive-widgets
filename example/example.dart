import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reactive_widgets/reactive_widgets.dart';

// Classes for use in examples only
class User {
  String name;
}

abstract class StateTest {}

class StateTest2 extends StateTest {
  String message = "Hello World";
}

class StateTest3 extends StateTest {
  bool check = false;
}

// A simple example page with all available reactive_widgets
// Streams controlers are started in the widget for examples only
class SimpleExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<SimpleExamplePage> {
  StreamController<String> _controller;
  StreamController<List<String>> _controllerList;
  StreamController<StateTest> _statControler;
  StreamController<User> _userController;
  StreamController<bool> _selectorController;
  StreamController<int> _intController;

  @override
  void initState() {
    _controller = StreamController<String>();
    _statControler = StreamController<StateTest>();
    _userController = StreamController<User>();
    _controllerList = StreamController<List<String>>();
    _selectorController = StreamController<bool>();
    _intController = StreamController<int>();

    super.initState();
  }

  @override
  void dispose() {
    _controller.close();
    _controllerList.close();
    _statControler.close();
    _userController.close();
    _selectorController.close();
    _intController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            // Reactive Builder example
            ReactiveBuilder<String>(
              stream: _controller.stream,
              builder: (BuildContext context, String data) => Text(data),
            ),

            // Reactive Builder example
            ReactiveListView<String>(
                stream: _controllerList.stream,
                itemBuilder: (BuildContext context, data) {
                  return ListTile(title: Text(data));
                }),

            // Reactive Builder example
            ReactiveStat<StateTest>(
              stream: _statControler.stream,
              builders: <BuilderState<StateTest>>[
                BuilderState<StateTest2>(
                    builder: (_, data) => Text(data.message)),
                BuilderState<StateTest3>(
                    builder: (_, data) => Text(data.check.toString())),
              ],
            ),

            // Reactive Selector example
            ReactiveSelector(
              stream: _selectorController.stream,
              ontrue: Container(),
              onfalse: Text("False"),
            ),

            // Reactive Selector Builder example
            ReactiveSelectorBuilder(
              stream: _selectorController.stream,
              trueBuilder: (_) => Container(),
              falseBuilder: (_) => Text("False"),
            ),

            // Reactive Condition example
            ReactiveCondition<int>(
              stream: _intController.stream,
              defaultBuilder: (_, data) => Container(),
              builders: <ConditionBuilder<int>>[
                ConditionBuilder<int>(
                    condition: (value) => value > 10,
                    builder: (_, data) => Text(data.toString())),
              ],
            ),
            // Reactive Condition example
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.add("Hello World");
          _controllerList.add(["1 - Hello", "2 - Hello", "3 - Hello"]);
        },
      ),
    );
  }
}
