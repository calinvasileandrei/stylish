import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StylishCircularButton extends StatelessWidget {
  final callBack;
  final icon;
  StylishCircularButton({Key key,this.callBack,this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.w,
      height: 180.h,
     decoration: BoxDecoration(
          color: Color(0xFFfa7b58),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Color(0xFFf78a6c).withOpacity(.6),
                offset: Offset(0.0, 10.0),
                blurRadius: 10.0)
          ]),
      child: RawMaterialButton(
        shape: CircleBorder(),
        child: Icon(
          icon,
          size: 90.w,
          color: Colors.white,
        ),
        onPressed: callBack,
      ),
    );
  }
}
