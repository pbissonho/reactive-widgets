import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reactive_widgets/reactive_widgets.dart';
import 'package:reactive_widgets/src/reactive_builder.dart';

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
            ReactiveBuilder<String>(
              stream: _controller.stream,
              builder: (BuildContext context, String data) => Text(data),
            ),
            ReactiveListView<String>(
                stream: _controllerList.stream,
                itemBuilder: (BuildContext context, data) {
                  return ListTile(title: Text(data));
                }),
            ReactiveStat<StateTest>(
              stream: _statControler.stream,
              builders: <BuilderState<StateTest>>[
                BuilderState<StateTest2>(
                    builder: (_, data) => Text(data.message)),
                BuilderState<StateTest3>(
                    builder: (_, data) => Text(data.check.toString())),
              ],
            ),
            ReactiveSelector(
              stream: _selectorController.stream,
              ontrue: Container(),
              onfalse: Text("False"),
            ),
            ReactiveCondition<int>(
              stream: _intController.stream,
              defaultBuilder: (_, data) => Container(),
              builders: <ConditionBuilder<int>>[
                ConditionBuilder<int>(
                    condition: (value) => value > 10,
                    builder: (_, data) => Text(data.toString())),
              ],
            ),
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
