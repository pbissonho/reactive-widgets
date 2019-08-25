import 'package:flutter/material.dart';
import '../reactive_widgets.dart';

typedef WidgetBuilder<T> = Widget Function(BuildContext context, T data);

class ReactiveBuilder<T> extends ReactiveWidget<T> {
  final WidgetBuilder<T> builder;
  final Widget Function(Object error) errorBuilder;
  final Widget Function() emptyBuilder;

  const ReactiveBuilder({
    Key key,
    @required Stream<T> stream,
    T initialData,
    @required this.builder,
    this.emptyBuilder,
    this.errorBuilder,
  }) : super(stream, initialData, key: key);

  @override
  Widget build(BuildContext context, T data) => builder(context, data);

  @override
  Widget emptyBuild() {
    return emptyBuilder != null ? emptyBuilder() : super.emptyBuild();
  }

  @override
  Widget errorBuild(Object error) {
    return errorBuilder != null ? errorBuilder(error) : super.errorBuild(error);
  }
}
