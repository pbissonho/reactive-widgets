import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:reactive_widgets/src/reactive_widget.dart';

class User {
  String name;
  String email;
}

class MyReactiveWidget extends ReactiveWidget<User> {
  MyReactiveWidget(Stream<User> stream, User initialData)
      : super(stream, initialData);

  @override
  Widget build(BuildContext context, User data) {
    return ListTile(
      title: Text(data.name),
      subtitle: Text(data.email),
    );
  }

  @override
  Widget emptyBuild() {
    return Container();
  }

  @override
  Widget errorBuild(Object error) {
    return Center(
      child: Text(error.toString()),
    );
  }
}
