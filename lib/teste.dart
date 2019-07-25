import 'package:flutter/material.dart';
import 'package:reactive_widgets/reactive_widgets.dart';
import 'package:reactive_widgets/src/reactive_builder.dart';

class ReactiveTeste extends StatefulWidget {
  @override
  _ReactiveTesteState createState() => _ReactiveTesteState();
}

class _ReactiveTesteState extends State<ReactiveTeste> {
  @override
  Widget build(BuildContext context) {
    Stream stream;

    return Column(
      children: <Widget>[
        ReactiveBuilder<String>(
          stream: null,
          initialData: null,
          builderWidget: (BuildContext context, data) {},
        ),
        ReactiveListView<String>(
          shrinkWrap: true,
          stream: stream,
          itemBuilder: (BuildContext context, element) {
            return ListTile(title: Text(element),);
          },
          )
      ],
    );
  }
}
