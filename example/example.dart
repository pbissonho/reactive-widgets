import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reactive_widgets/reactive_widgets.dart';
import 'package:reactive_widgets/src/reactive_builder.dart';

class SimpleExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<SimpleExamplePage> {
  var _controller;
  var _controllerList;

  @override
  void initState() {
    _controller = StreamController<String>();
    _controllerList = StreamController<List<String>>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                })
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
