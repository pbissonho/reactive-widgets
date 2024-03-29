import 'package:flutter/widgets.dart';
import 'package:reactive_widgets/reactive_widgets.dart';

class ReactiveListView<T> extends ReactiveWidget<List<T>> {
  final Stream<List<T>> stream;
  final List<T> initialData;
  final Widget Function(BuildContext context, T itemData) itemBuilder;
  final Widget Function(BuildContext context) listEmptyBuilder;
  final Widget separatorBuilder;
  final Key key;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController controller;
  final bool primary;
  final ScrollPhysics physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry padding;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;

  ReactiveListView({
    this.listEmptyBuilder,
    @required this.stream,
    @required this.itemBuilder,
    this.initialData,
    this.key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.separatorBuilder,
    this.shrinkWrap = true,
  }) : super(stream, initialData);

  @override
  Widget build(BuildContext context, List<T> data) {
    List<T> list = data;
    ListView listView;

    if (list.isEmpty) {
      if (listEmptyBuilder != null) return listEmptyBuilder(context);

      return Container();
    }

    if (separatorBuilder != null) {
      listView = ListView.separated(
        scrollDirection: scrollDirection,
        addSemanticIndexes: addSemanticIndexes,
        addRepaintBoundaries: addRepaintBoundaries,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        padding: padding,
        primary: primary,
        physics: physics,
        controller: controller,
        shrinkWrap: shrinkWrap,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return itemBuilder(context, list[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return separatorBuilder;
        },
      );
    } else {
      listView = ListView.builder(
        scrollDirection: scrollDirection,
        addSemanticIndexes: addSemanticIndexes,
        addRepaintBoundaries: addRepaintBoundaries,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        padding: padding,
        primary: primary,
        physics: physics,
        controller: controller,
        shrinkWrap: shrinkWrap,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return itemBuilder(context, list[index]);
        },
      );
    }

    return listView;
  }
}
