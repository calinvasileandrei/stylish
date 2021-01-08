import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/Utils/StylishSkeleton.dart';
import 'package:stylish/Utils/global.dart';
import 'package:stylish/View/SettingsView/SubViews/AboutMeView/AboutMeView.dart';
import 'package:stylish/View/SettingsView/SubViews/AdvancedSettingsView/AdvancedSettingsView.dart';
import 'package:stylish/View/SettingsView/SubViews/CloudBackupView/CloudBackupView.dart';
import 'package:stylish/View/SettingsView/SubViews/ManageCategoriesView/ManageCateogriesView.dart';

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
                  _buildOption("Manage Categorys",ManageCategoriesView()),
                  _buildOption("Cloud Backup",CloudBackupView()),
                  _buildOption("Advanced Settings",AdvancedSettings()),
                  _buildOption("About Me",AboutMeView()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOption(_text,_navigateTo) {
    return GestureDetector(
      child:  Container(
        height: 180.h,
        child: Card(
          shape: stylishCardShape,
          color: Colors.white,
          elevation: 2,
          child: ListTile(
            title: Text(_text),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_forward_ios,color: Colors.black,size: 48.sp,),
              ],
            ),
          ),
        ),
      ),
      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context)=> _navigateTo)),
    );
  }
}
