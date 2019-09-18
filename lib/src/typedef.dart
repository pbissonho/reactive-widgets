import 'package:flutter/cupertino.dart';

typedef RWBuilder<T> = Widget Function(BuildContext context, T data);
typedef ErrorBuilder<T> = Function(Object error);
typedef EmptyBuilder = Widget Function();
