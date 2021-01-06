import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StylishLargeButton extends StatelessWidget {
  final buttonText;
  final callback;
  StylishLargeButton({Key key,this.buttonText,this.callback}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth * 0.95,
      height: 140.h,
      margin: EdgeInsets.only(top: 100.h),
      decoration: BoxDecoration(
          color: Color(0xFFfa7b58),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
                color: Color(0xFFf78a6c).withOpacity(.6),
                offset: Offset(0.0, 10.0),
                blurRadius: 10.0)
          ]),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(),
        child: Text(buttonText,
            style: TextStyle(
                color: Colors.white,
                fontSize: 72.sp,
                fontWeight: FontWeight.bold)),
        onPressed:  callback,
      ),
    );
  }
}
