import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Stack(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenWidth *0.25,
          ),
          SafeArea(
            child: Container(
              height: ScreenUtil().screenHeight,
              width: ScreenUtil().screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: ScreenUtil().screenWidth,
                    height: ScreenUtil().screenHeight*0.07,
                    padding: EdgeInsets.only(left: 40.w,right: 40.w,top: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Stylish", style: Theme.of(context).textTheme.headline1
                        ),
                        Text("Choose your outfit", style: Theme.of(context).textTheme.headline6)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.red,

                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
