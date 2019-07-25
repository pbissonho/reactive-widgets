import 'dart:async';
import 'package:flutter/material.dart';

class DialogData {
  final String title;
  final String contentTextData;
  final String confirmButtonText;
  final String cancelButtonText;
  final Function onConfirme;
  final Function onCancel;

  DialogData(
      {this.onCancel,
      this.confirmButtonText = "Confirme",
      this.cancelButtonText = "Cancel",
      this.title,
      this.contentTextData,
      this.onConfirme});
}

class ReactiveDialogStyle {
  final EdgeInsetsGeometry titlePadding;
  final TextStyle titleTextStyle;
  final Widget content;
  final TextStyle contentTextStyle;
  final List<Widget> actions;
  final Color backgroundColor;
  final double elevation;
  final String semanticLabel;
  final ShapeBorder shape;

  ReactiveDialogStyle(
      this.titlePadding,
      this.titleTextStyle,
      this.content,
      this.contentTextStyle,
      this.actions,
      this.backgroundColor,
      this.elevation,
      this.semanticLabel,
      this.shape);
}

class ReactiveDialog {
  final ReactiveDialogStyle dialogStyle;
  final GlobalKey<ScaffoldState> scaffoldKey;

  final Stream<DialogData> stream;
  StreamSubscription sub;
  ReactiveDialog({
    @required this.scaffoldKey,
    @required this.stream,
    this.dialogStyle,
  }) {
    sub = stream.listen((onData) {
      showRxDialog(dialogData: onData);
    });
  }

  void dispose() {
    sub.cancel();
  }

  void showRxDialog({DialogData dialogData}) {
    showDialog(
      context: scaffoldKey.currentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(dialogData.title),
          content: new Text(dialogData.contentTextData),
          actions: <Widget>[
            new FlatButton(
              child: new Text(dialogData.cancelButtonText),
              onPressed: () {
                if (dialogData.onCancel != null) {
                  dialogData?.onCancel();
                }

                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(dialogData.confirmButtonText),
              onPressed: () {
                if (dialogData.onConfirme != null) {
                  dialogData?.onConfirme();
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
