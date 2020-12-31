import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/Utils/global.dart';

import 'View/HomeView/HomeView.dart';

void main() {
  runApp(ScreenUtilInit(
    designSize: Size(1125, 2436),
    allowFontScaling: false,
    child: MaterialApp(
      theme: stylishTheme,
      title: 'Stylish',
      home: new TabControllerApp(),
    ),
  ));
}

class TabControllerApp extends StatefulWidget {
  @override
  _TabControllerAppState createState() => _TabControllerAppState();
}

class _TabControllerAppState extends State<TabControllerApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: new Scaffold(
          bottomNavigationBar: _buildNavBar(context),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              new HomeView(),
              new Container(color: Colors.blue,),
            ],
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildNavBar(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        height: 50,
        child: new TabBar(
          tabs: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                //boxShadow: shadowsNavBarColor,
              ),
              width: 50,
              child: Tab(
                icon: new Icon(
                  Icons.home ,
                  size: 30,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                //boxShadow: shadowsNavBarColor,
              ),
              width: 50,
              child: Tab(
                icon: new Icon(
                  Icons.settings ,
                  size: 30,
                ),
              ),
            ),
          ],
          unselectedLabelColor: Theme.of(context).primaryColorDark,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: Theme.of(context).accentColor,
          labelColor: Theme.of(context).accentColor,
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    //ListViewClothes l = new ListViewClothes();
    return Container(
      width: 180.w,
      height: 180.h,
      margin: EdgeInsets.only(bottom: 70.h),
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
          Icons.add,
          size: 90.w,
          color: Colors.white,
        ),
        onPressed: () {
          //_insert();
        },
      ),
    );
  }
}

