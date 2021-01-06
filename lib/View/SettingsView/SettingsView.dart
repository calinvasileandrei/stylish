import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/Utils/StylishSkeleton.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return StylishSkeleton(
      subtitle: "Settings",
      child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    'assets/logo_white512.png',
                    width: ScreenUtil().setWidth(1200.w),
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
            Padding(
              padding: new EdgeInsets.all(14.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildOption("Manage Categorys"),
                    _buildOption("Cloud Backup"),
                    _buildOption("Advanced Settings"),
                    _buildOption("About Me"),

                  ],

                ),
              ),
            )
          ],
        ),

      );
  }

  Widget _buildOption(_text){
    return   GestureDetector(
      child: Container(
        width: ScreenUtil().screenWidth,
          margin: EdgeInsets.only(top:96.h,bottom: 48.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left:ScreenUtil().screenWidth * 0.10, right: ScreenUtil().screenWidth * 0.10  ) ,
                child: Icon(Icons.arrow_forward_ios,color: Colors.black45,),
              ),
              Text(_text, style: Theme.of(context).textTheme.headline4.copyWith(fontSize: 72.sp),),
            ],
          )
      ),
      onTap: ()=>{},
    );
  }
}
