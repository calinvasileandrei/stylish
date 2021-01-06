import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StylishFormInput extends StatelessWidget {
  TextEditingController controller;
  String name;
  Widget suffix=null;
  bool disabled;
  StylishFormInput({Key key,this.name,this.controller,this.suffix,this.disabled}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil().screenWidth * 0.9,
        padding: new EdgeInsets.fromLTRB(24.w, 48.h, 24.w, 48.h),
        child: TextField(
          readOnly: disabled==true? true:false,
          controller: controller,
          decoration: InputDecoration(
              labelText: name,
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(50.w, 37.h, 50.w, 37.h),
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              suffixIcon: suffix),
        ));
  }
}
