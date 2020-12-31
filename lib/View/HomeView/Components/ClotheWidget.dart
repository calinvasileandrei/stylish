import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:stylish/Models/Clothe.dart';

class ClotheWidget extends StatelessWidget {
  ClotheWidget(this.index,this.clothe);
  final int index;
  final Clothe clothe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(
            left: 90.w,
            top: 50.h,
            bottom: 50.h
        ),
        child: SizedBox(
          width: 500.w,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 120.h),
                child: Container(
                  decoration: BoxDecoration(
                      color: (index % 2 == 0)
                          ? Colors.white
                          : Color(0xFF2a2d3f),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 10.0),
                            blurRadius: 10.0)
                      ],
                      borderRadius: BorderRadius.circular(12.0)),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: ClipRRect(
                        borderRadius: new BorderRadius.circular(9.0),
                        child: clothe.ImageFile == null ||
                            clothe.ImageFile == ""
                            ? LimitedBox(
                            child: FadeInImage.assetNetwork(
                              placeholder: "assets/logo_withe512.png",
                              image: clothe.Image,
                              width: 350.w,
                              fit: BoxFit.fill,
                            ),
                            maxHeight: 600.h,
                            maxWidth: 500.w)
                            : ClipRRect(
                          borderRadius:
                          new BorderRadius.circular(9.0),
                          child: LimitedBox(
                              child: Image.memory(
                                base64Decode(clothe.ImageFile),
                                fit: BoxFit.fill,
                              ),
                              maxHeight: 600.h,
                              maxWidth: 500.w),
                        )),
                    decoration: new BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: (index % 2 == 0)
                              ? Colors.black12
                              : Colors.white12,
                          blurRadius: 10.0,
                          offset: Offset(10.0, 15.0),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        35.w,
                        30.h,
                        35.w,
                        0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 12.h),
                          child: Text(
                            clothe.Name,
                            style: TextStyle(
                                fontSize: 40.sp,
                                fontFamily: "Montserrat-Bold",
                                color: (index % 2 == 0)
                                    ? Color(0xFF2a2d3f)
                                    : Colors.white),
                          ),
                        ),
                        Text(clothe.Type,
                            style: TextStyle(
                                fontSize: 35.sp,
                                fontFamily: "Montserrat-Medium",
                                color: (index % 2 == 0)
                                    ? Color(0xFF2a2d3f)
                                    : Colors.white)),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(clothe.Price,
                                  style: TextStyle(
                                      fontSize: 60.sp,
                                      fontFamily: "Montserrat-Bold",
                                      color: (index % 2 == 0)
                                          ? Color(0xFF2a2d3f)
                                          : Colors.white)),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.exit_to_app,
                                color: (index % 2 == 0)
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              onPressed: () => {}//_launchURL(index, _items),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      onTap: () =>
      {}//{_navigateToClothe(context, _items[index], _items, index)},
    );
  }
}
