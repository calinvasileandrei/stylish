import 'package:flutter/material.dart';

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
          borderRadius: BorderRadius.all(Radius.circular(14.0))),
      title: new Text("Delete Item"),
      content: new Text("Are you sure to delete this Item?"),
      actions: <Widget>[
        leftButton,
        rightButton
     ],
    );
  }
}
