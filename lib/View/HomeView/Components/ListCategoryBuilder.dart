import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/Models/Clothe.dart';
import 'package:stylish/Models/CategoryClothes.dart';
import 'package:stylish/View/HomeView/Components/CategoryBuilder.dart';

class ListCategoryBuilder extends StatefulWidget {
  final List<CategoryClothes> categoryClothes;
  ListCategoryBuilder({Key key, @required this.categoryClothes})
      : super(key: key);

  @override
  _ListCategoryBuilderState createState() => _ListCategoryBuilderState();
}

class _ListCategoryBuilderState extends State<ListCategoryBuilder> {
  final Clothe placeholderClothe = new Clothe("No Items There", "", "",  "",false,
      "Start adding some clothes to this category!");
  final List<Clothe> placeholderList = new List<Clothe>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    placeholderList.add(placeholderClothe);
    log(widget.categoryClothes.toString());
  }

  @override
  Widget build(BuildContext context) {
    return widget.categoryClothes == null || widget.categoryClothes.isEmpty
        ? Center(
            child: Text(
            "You seem new here, add your first clothe!",
            style: Theme.of(context).textTheme.headline6,
          ))
        : ListView.builder(
            itemCount: widget.categoryClothes.length,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                  width: ScreenUtil().screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 40.w, right: 40.w, top: 40.h),
                        child: Text(
                          widget.categoryClothes[index].category,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      widget.categoryClothes[index].clothes.isNotEmpty
                          ? CategoryBuilder(
                              widget.categoryClothes[index].clothes,
                              widget.categoryClothes[index].category)
                          : CategoryBuilder(placeholderList,
                              widget.categoryClothes[index].category),
                    ],
                  ));
            });
  }
}
