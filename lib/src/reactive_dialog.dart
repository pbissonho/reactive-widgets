import 'dart:async';
import 'package:flutter/material.dart';

class DialogData {
  final String title;
  final String contentTextData;
  final String confirmButtonName;
  final String cancelButtonName;
  final Function onConfirme;
  final Function onCancel;

  DialogData(
      {this.onCancel,
      this.confirmButtonName = "Confirme",
      this.cancelButtonName = "Cancel",
      this.title,
      this.contentTextData,
      this.onConfirme});
}

class ReactiveDialogStyle {
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry titlePadding;
  final TextStyle titleTextStyle;
  final TextStyle contentTextStyle;
  final Color backgroundColor;
  final double elevation;
  final String semanticLabel;
  final ShapeBorder shape;

  ReactiveDialogStyle(
      this.titlePadding,
      this.titleTextStyle,
      this.contentTextStyle,
      this.backgroundColor,
      this.elevation,
      this.semanticLabel,
      this.shape,
      this.contentPadding);
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
  })  : assert(scaffoldKey != null),
        assert(stream != null) {
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
          // contentPadding: dialogStyle?.contentPadding,
          // contentTextStyle: dialogStyle?.contentTextStyle,
          // backgroundColor: dialogStyle?.backgroundColor,
          // titleTextStyle: dialogStyle?.titleTextStyle,
          // elevation: dialogStyle?.elevation,
          // shape: dialogStyle?.shape,
          // semanticLabel: dialogStyle?.semanticLabel,
          // titlePadding: dialogStyle?.titlePadding,
          title: Text(dialogData.title),
          content: Text(dialogData.contentTextData),
          actions: <Widget>[
            FlatButton(
              child: Text(dialogData.cancelButtonName),
              onPressed: () {
                if (dialogData.onCancel != null) {
                  dialogData?.onCancel();
                }

                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(dialogData.confirmButtonName),
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
