import 'package:flutter/material.dart';
import '../reactive_widgets.dart';

class ReactiveBuilder<T> extends ReactiveWidget<T> {
  final Stream<T> stream;
  final T initialData;
  final Widget Function(BuildContext context, T data) builderWidget;
  final Widget Function() onErroBuilder;

  const ReactiveBuilder(
      {Key key,
      @required this.stream,
      @required this.builderWidget,
      this.onErroBuilder,
      this.initialData})
      : super(key: key, stream: stream, initialData: initialData);

  @override
  Widget reactiveBuild(BuildContext context, T data) {
    return builderWidget(context, data);
  }

  @override
  Widget hasErroBuilder() {
    if (onErroBuilder != null) {
      return onErroBuilder();
    } else {
      return super.hasErroBuilder();
    }
  }
}
