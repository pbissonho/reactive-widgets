import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:reactive_widgets/reactive_widgets.dart';
import 'package:reactive_widgets/src/typedef.dart';

class ReactiveCondition<T> extends ReactiveBuilder<T> {
  final List<ConditionBuilder<T>> builders;

  ReactiveCondition({
    @required this.builders,
    @required Stream<T> stream,
    T initialData,
    @required RWBuilder<T> defaultBuilder,
    ErrorBuilder errorBuilder,
    EmptyBuilder emptyBuilder,
  }) : super(
            stream: stream,
            initialData: initialData,
            builder: defaultBuilder,
            errorBuilder: errorBuilder,
            emptyBuilder: emptyBuilder);

  @override
  Widget build(BuildContext context, T data) {
    var currentBuilder;

    currentBuilder = builders.firstWhere((b) => b.condition(data),
        orElse: () =>
            ConditionBuilder(builder: builder, condition: (data) => true));

    return currentBuilder.builder(context, data);
  }
}

class ConditionBuilder<T> {
  final RWBuilder<T> builder;
  final bool Function(T data) condition;

  ConditionBuilder({
    @required this.condition,
    @required this.builder,
  });
}
