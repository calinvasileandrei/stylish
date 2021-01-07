import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:stylish/Models/Clothe.dart';
import 'package:stylish/View/EditClotheView/EditClotheView.dart';
import 'package:url_launcher/url_launcher.dart';

class ClotheWidget extends StatelessWidget {
  ClotheWidget(this.index, this.clothe);

  final int index;
  final Clothe clothe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(
          padding: EdgeInsets.only(left: 90.w, top: 50.h, bottom: 50.h),
          child: SizedBox(
            width: 500.w,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 120.h),
                  child: Container(
                    height: ScreenUtil().screenHeight * 0.3,
                    decoration: BoxDecoration(
                        color:
                            (index % 2 == 0) ? Colors.white : Color(0xFF2a2d3f),
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
                    Center(child: _buildFloatingImage()),
                    Padding(
                      padding: EdgeInsets.fromLTRB(35.w, 30.h, 35.w, 10.h),
                      child: _buildCardDetails(),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        onTap: () => clothe.name=="No Items There"? null: Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditClotheView(
                      clothe: clothe,
                    ))));
  }

  void _launchURL(link) async {
    if (link != null && link != '') {
      if (await canLaunch(link)) {
        await launch(link);
      } else {
        log('Could not launch $link');
      }
    }
  }

  Widget _buildFloatingImage() {
    return Container(
      child: ClipRRect(
          borderRadius: new BorderRadius.circular(9.0),
          child: (clothe.image == "" ||clothe.image == null)
              ? ClipRRect(
            borderRadius: new BorderRadius.circular(9.0),
            child: LimitedBox(
                child: Image.asset(
                  "assets/logo_white512.png",
                  fit: BoxFit.fill,
                ),
                maxHeight: 350.h,
                maxWidth: 500.w),
          )
              : clothe.isLocalImage
              ? ClipRRect(
            borderRadius: new BorderRadius.circular(9.0),
            child: LimitedBox(
                child: Image.memory(
                  base64Decode(clothe.image),
                  fit: BoxFit.fill,
                ),
                maxHeight: 350.h,
                maxWidth: 500.w),
          )
              : FadeInImage.assetNetwork(
            placeholder: 'assets/logo_white512.png',
            image: clothe.image,
            height: 350.h,
            fit: BoxFit.contain,
          )),
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: (index % 2 == 0) ? Colors.black12 : Colors.white12,
            blurRadius: 10.0,
            offset: Offset(10.0, 15.0),
          ),
        ],
      ),
    );
  }

  Widget _buildCardDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 12.h, top: 24.h),
          child: clothe.name.length <= 34
              ? Text(
                  clothe.name,
                  style: TextStyle(
                      fontSize: 40.sp,
                      fontFamily: "Montserrat-Bold",
                      color:
                          (index % 2 == 0) ? Color(0xFF2a2d3f) : Colors.white),
                )
              : new SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    clothe.name,
                    style: TextStyle(
                        fontSize: 40.sp,
                        fontFamily: "Montserrat-Bold",
                        color: (index % 2 == 0)
                            ? Color(0xFF2a2d3f)
                            : Colors.white),
                  ),
                ),
        ),
        Text(clothe.category,
            style: TextStyle(
                fontSize: 35.sp,
                fontFamily: "Montserrat-Medium",
                color: (index % 2 == 0) ? Color(0xFF2a2d3f) : Colors.white)),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(clothe.price,
                  style: TextStyle(
                      fontSize: 60.sp,
                      fontFamily: "Montserrat-Bold",
                      color:
                          (index % 2 == 0) ? Color(0xFF2a2d3f) : Colors.white)),
            ),
            IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  color: (index % 2 == 0) ? Colors.black : Colors.white,
                ),
                onPressed: () => clothe.name=="No Items There"? null: _launchURL(clothe.link))
          ],
        ),
      ],
    );
  }
}
