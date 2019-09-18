import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:reactive_widgets/reactive_widgets.dart';
import 'package:reactive_widgets/src/typedef.dart';

class ReactiveStat<T> extends ReactiveBuilderBase<T> {
  final List<BuilderState<T>> builders;

  ReactiveStat({
    @required this.builders,
    @required Stream<T> stream,
    T initialData,
    ErrorBuilder errorBuilder,
    EmptyBuilder emptyBuilder,
  })  : assert(builders != null),
        super(
            stream: stream,
            initialData: initialData,
            errorBuilder: errorBuilder,
            emptyBuilder: emptyBuilder);

  @override
  Widget build(BuildContext context, dynamic data) {
    var currentBuilder;
    try {
      currentBuilder = builders.firstWhere((b) {
        return b.type == typeOf(data.runtimeType);
      });
    } catch (e) {
      throw new Exception(
          "Not have BuilderState for type ${data.runtimeType.toString()}");
    }

    Widget widget = currentBuilder.builder(context, data);
    return widget;
  }
}

String typeOf(Type type) => type.toString();

class BuilderState<T> {
  final RWBuilder<T> builder;
  final String type;

  BuilderState({
    this.builder,
  })  : assert(builder != null),
        type = typeOf(T) {
    if (T == dynamic) {
      throw new Exception("BuilderState not can have a dynamic type");
    }
  }
}
