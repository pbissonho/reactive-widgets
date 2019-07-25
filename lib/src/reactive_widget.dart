import 'package:flutter/material.dart';

abstract class ReactiveWidget<T> extends StatelessWidget {
  final Stream<T> stream;
  final T initialData;
  const ReactiveWidget({
    Key key,
    @required this.stream,
    this.initialData,
  }) : super(key: key);

  @protected
  Widget reactiveBuild(BuildContext context, T data);

  Widget hasErroBuilder() {
    return Center(
      child: Text("Error on builder reactive widget"),
    );
  }

  Widget loadingDataBuilder() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      initialData: initialData,
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError) return hasErroBuilder();

        if (!snapshot.hasData) return loadingDataBuilder();

        return reactiveBuild(context, snapshot.data);
      },
    );
  }
}
