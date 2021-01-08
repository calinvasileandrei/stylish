import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/Components/StylishFormInput.dart';
import 'package:stylish/Utils/global.dart';

class StylishInputAlertDialog extends StatefulWidget {
  final title;
  final rightButton;
  final leftButton;
  String text;
  TextEditingController textController;

  StylishInputAlertDialog({Key key,this.title,this.leftButton,this.rightButton,this.textController,this.text}):super(key: key);

  @override
  _StylishInputAlertDialogState createState() => _StylishInputAlertDialogState(this.title,this.leftButton,this.rightButton,this.textController,this.text);
}

class _StylishInputAlertDialogState extends State<StylishInputAlertDialog> {
  final _title;
  final _rightButton;
  final _leftButton;
  String _text;
  TextEditingController _textController;

  _StylishInputAlertDialogState(this._title,this._leftButton,this._rightButton,this._textController,this._text);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: stylishBorderRadius),
      title: Text(_title),
      content: Container(
        height: 250.h,
        child: Center(
          child: StylishFormInput(name:_text,controller: _textController,),
        ),
      ),
      actions: <Widget>[
        _leftButton,
        _rightButton
      ],
    );
  }
}



