import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/Models/Clothe.dart';
import 'package:stylish/View/HomeView/Components/CategoryBuilder.dart';

class ListCategoryBuilder extends StatefulWidget {
  final Map<String, List<Clothe>> categorys;
  ListCategoryBuilder({Key key, @required this.categorys}): super(key:key);

  @override
  _ListCategoryBuilderState createState() => _ListCategoryBuilderState();
}

class _ListCategoryBuilderState extends State<ListCategoryBuilder> {

  final Clothe placeholderClothe = new Clothe("No Items There", "", "", "", "", "Start adding some clothes to this category!");
  final List<Clothe> placeholderList = new List<Clothe>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    placeholderList.add(placeholderClothe);
    log("is empty: "+widget.categorys.isEmpty.toString());
    log("categorys"+widget.categorys.toString());
  }

  @override
  Widget build(BuildContext context) {

    return widget.categorys.isEmpty
        ? Center(
        child: Text(
          "You seem new here, add your first clothe!",
          style: Theme.of(context).textTheme.headline6,
        ))
        : ListView.builder(
        itemCount: widget.categorys.length,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          String categoryNameKey = widget.categorys.keys.elementAt(index);
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
                  widget.categorys[categoryNameKey].isNotEmpty?
                  CategoryBuilder(
                      widget.categorys[categoryNameKey], categoryNameKey):
                  CategoryBuilder(placeholderList, categoryNameKey),
                ],
              ));
        });
  }
}


