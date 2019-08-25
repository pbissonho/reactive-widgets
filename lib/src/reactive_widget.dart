import 'package:flutter/material.dart';

abstract class ReactiveWidget<T> extends StatefulWidget {
  final Stream<T> stream;
  final T initialData;
  Widget build(BuildContext context, T data);

  const ReactiveWidget(this.stream, this.initialData, {Key key})
      : super(key: key);

  Widget errorBuild(Object error) {
    return Center(
      child: Text(error),
    );
  }

  Widget emptyBuild() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  _ReactiveWidgetState<T> createState() => _ReactiveWidgetState<T>();
}

class _ReactiveWidgetState<T> extends State<ReactiveWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      initialData: widget.initialData,
      stream: widget.stream,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError) return widget.errorBuild(snapshot.error);
        if (snapshot.hasData) return widget.build(context, snapshot.data);
        return widget.emptyBuild();
      },
    );
  }
}
