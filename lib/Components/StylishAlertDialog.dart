import 'package:flutter/material.dart';
import 'package:stylish/Utils/global.dart';

class StylishAlertDialog extends StatelessWidget {
  final title;
  final content;
  final rightButton;
  final leftButton;
  StylishAlertDialog({Key key,this.title,this.content,this.leftButton,this.rightButton}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: stylishBorderRadius),
      title: new Text(title),
      content: new Text(content),
      actions: <Widget>[
        leftButton,
        rightButton
     ],
    );
  }
}
