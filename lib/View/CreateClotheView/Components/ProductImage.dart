import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImage extends StatelessWidget {
  final image;
  final imageText;
  ProductImage({Key key, this.image,this.imageText}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 400.w,
        child: Container(
            child: ClipRRect(
              borderRadius: new BorderRadius.circular(9.0),
              child: image == null || image == ""
                  ? FadeInImage.assetNetwork(
                placeholder: 'assets/logo_white512.png',
                image: imageText,
                width: ScreenUtil().setWidth(400),
                fit: BoxFit.contain,
              )
                  : new Image.memory(base64Decode(image)),
            ),
            decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: Offset(4.0, 10.0),
                ),
              ],
            )));
  }
}
