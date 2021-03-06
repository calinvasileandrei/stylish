import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/Utils/global.dart';

class StylishFormInput extends StatelessWidget {
  TextEditingController controller;
  String name;
  Widget suffix=null;
  bool disabled;
  StylishFormInput({Key key,this.name,this.controller,this.suffix,this.disabled}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Color(0xFFfa7b58)),
      child: Container(
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
                OutlineInputBorder(borderRadius: stylishBorderRadius),
                suffixIcon: suffix),
          )),
    );
  }
}
