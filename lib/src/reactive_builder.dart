import 'package:flutter/widgets.dart';
import 'package:reactive_widgets/src/reactive_widget.dart';
import 'package:reactive_widgets/src/typedef.dart';

class ReactiveBuilder<T> extends ReactiveBuilderBase<T> {
  final RWBuilder<T> builder;

  const ReactiveBuilder({
    Key key,
    @required Stream<T> stream,
    T initialData,
    @required this.builder,
    EmptyBuilder emptyBuilder,
    ErrorBuilder errorBuilder,
  }) : super(
            stream: stream,
            emptyBuilder: emptyBuilder,
            errorBuilder: errorBuilder);

  @override
  Widget build(BuildContext context, T data) => builder(context, data);
}

abstract class ReactiveBuilderBase<T> extends ReactiveWidget<T> {
  final ErrorBuilder<T> errorBuilder;
  final EmptyBuilder emptyBuilder;

  const ReactiveBuilderBase({
    Key key,
    @required Stream<T> stream,
    T initialData,
    this.emptyBuilder,
    this.errorBuilder,
  }) : super(stream, initialData, key: key);

  @override
  Widget emptyBuild() {
    return emptyBuilder != null ? emptyBuilder() : super.emptyBuild();
  }

  @override
  Widget errorBuild(BuildContext context, Object error) {
    return errorBuilder != null
        ? errorBuilder(error)
        : super.errorBuild(context, error);
  }
}
