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
    return UserAccountsDrawerHeader(
      accountName: Text(data.name),
      accountEmail: Text(data.email),
    );
  }

  @override
  Widget emptyBuild() {
    return Container();
  }

  @override
  Widget errorBuild(_, Object error) {
    return Center(
      child: Text(error.toString()),
    );
  }
}
