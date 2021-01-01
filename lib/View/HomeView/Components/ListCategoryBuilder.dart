import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/Models/Clothe.dart';
import 'package:stylish/View/HomeView/Components/CategoryBuilder.dart';

class ListCategoryBuilder extends StatelessWidget {
  ListCategoryBuilder(this.categorys);
  final Map<String, List<Clothe>> categorys;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: categorys.length,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          String categoryNameKey = categorys.keys.elementAt(index);
          return Container(
              width: ScreenUtil().screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 40.w, right: 40.w, top: 40.h),
                    child: Text(
                      categoryNameKey,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  CategoryBuilder(categorys[categoryNameKey], categoryNameKey),
                ],
              ));
        });
  }
}
