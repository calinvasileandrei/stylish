import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImage extends StatelessWidget {
  final image;
  final isLocalImage;

  ProductImage({Key key, this.image, this.isLocalImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 400.w,
        child: Container(
            child: ClipRRect(
                borderRadius: new BorderRadius.circular(9.0),
                child: (image == "" || image == null)
                    ? ClipRRect(
                        borderRadius: new BorderRadius.circular(9.0),
                        child: LimitedBox(
                            child: Image.asset(
                              "assets/logo_white512.png",
                              fit: BoxFit.fill,
                            ),
                            maxHeight: 550.h),
                      )
                    : isLocalImage
                        ? ClipRRect(
                            borderRadius: new BorderRadius.circular(9.0),
                            child: LimitedBox(
                                child: Image.memory(
                                  base64Decode(image),
                                  fit: BoxFit.fill,
                                ),
                                maxHeight: 550.h),
                          )
                        : FadeInImage.assetNetwork(
                            placeholder: 'assets/logo_white512.png',
                            image: image,
                            height: 550.w,
                            fit: BoxFit.contain,
                          )),
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
