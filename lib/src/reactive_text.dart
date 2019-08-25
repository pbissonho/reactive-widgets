import 'package:flutter/material.dart';
import 'package:reactive_widgets/reactive_widgets.dart';

class ReactiveText extends ReactiveWidget<String> {
  final Stream<String> stream;
  final String initialData;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Locale locale;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int maxLines;
  final String semanticsLabel;

  ReactiveText(
      {Key key,
      @required this.stream,
      this.initialData,
      this.style,
      this.strutStyle,
      this.textAlign,
      this.textDirection,
      this.locale,
      this.softWrap,
      this.overflow,
      this.textScaleFactor,
      this.maxLines,
      this.semanticsLabel})
      : super(stream, initialData, key: key);

  @override
  Widget build(BuildContext context, String data) {
    return Text(
      data,
      textAlign: textAlign,
      semanticsLabel: semanticsLabel,
      textDirection: textDirection,
      textScaleFactor: textScaleFactor,
      softWrap: softWrap,
      strutStyle: strutStyle,
      style: style,
      overflow: overflow,
      locale: locale,
      maxLines: maxLines,
    );
  }
}
