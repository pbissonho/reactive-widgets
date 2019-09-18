import 'package:flutter/material.dart';
import 'package:reactive_widgets/reactive_widgets.dart';
import 'package:reactive_widgets/src/typedef.dart';

class ReactiveSelector extends ReactiveBuilderBase<bool> {
  final Widget ontrue;
  final Widget onfalse;

  ReactiveSelector({
    Key key,
    @required this.ontrue,
    @required this.onfalse,
    @required Stream<bool> stream,
    EmptyBuilder emptyBuilder,
    ErrorBuilder errorBuilder,
    bool initialData,
  })  : assert(ontrue != null),
        assert(onfalse != null),
        super(stream: stream, initialData: initialData);

  @override
  Widget build(BuildContext context, bool data) {
    if (data) return ontrue;
    return onfalse;
  }
}

class ReactiveSelectorBuilder extends ReactiveBuilderBase {
  final Widget Function(BuildContext context) trueBuilder;
  final Widget Function(BuildContext context) falseBuilder;

  ReactiveSelectorBuilder({
    Key key,
    @required this.trueBuilder,
    @required this.falseBuilder,
    @required Stream<bool> stream,
    EmptyBuilder emptyBuilder,
    ErrorBuilder errorBuilder,
    bool initialData,
  })  : assert(trueBuilder != null),
        assert(falseBuilder != null),
        super(
            key: key,
            stream: stream,
            emptyBuilder: emptyBuilder,
            errorBuilder: errorBuilder);

  @override
  Widget build(BuildContext context, data) {
    if (data) return trueBuilder(context);
    return falseBuilder(context);
  }
}
