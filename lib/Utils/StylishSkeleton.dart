import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StylishSkeleton extends StatelessWidget {
  StylishSkeleton({Key key, this.child, this.iconButton, this.subtitle})
      : super(key: key);
  final Widget child;
  final String subtitle;
  final IconButton iconButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Stack(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenWidth * 0.25,
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: ScreenUtil().screenWidth,
                  padding: EdgeInsets.only(left: 20.w, top: 20.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (iconButton != null) iconButton,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Stylish",
                              style: Theme.of(context).textTheme.headline1),
                          Text(subtitle,
                              style: Theme.of(context).textTheme.headline6)
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(child: child)
              ],
            ),
          )
        ],
      ),
    );
  }
}
