import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/Components/StylishCircularButton.dart';
import 'package:stylish/DB/DataAccessObject/CategoryClotheDao.dart';
import 'package:stylish/Utils/global.dart';
import 'package:stylish/View/CreateClotheView/CreateClotheView.dart';
import 'package:stylish/View/HomeView/bloc/HomeBloc.dart';
import 'package:stylish/View/SettingsView/SettingsView.dart';
import 'View/HomeView/HomeView.dart';

void main() {
  runApp(ScreenUtilInit(
    designSize: Size(1125, 2436),
    allowFontScaling: false,
    child:BlocProvider(
        create: (context) => HomeBloc(repository: CategoryClotheDao()),
        child:MaterialApp(
            theme: stylishTheme,
            title: 'Stylish',
            debugShowCheckedModeBanner: false,
            home: new TabControllerApp()
        )
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
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 70.h),
        child: StylishCircularButton(icon:Icons.add,callBack: ()=> Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => new CreateClotheView()),
        )),
      ),
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
              new SettingsView()
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
                  Icons.home,
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
                  Icons.settings,
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

}
