import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/Utils/global.dart';
import 'package:stylish/View/CreateClotheView/bloc/CreateClotheBloc.dart';

class DropDownCategories extends StatefulWidget {
  final callback;
  String currentType;
  DropDownCategories({Key key,this.callback ,this.currentType}):super(key:key);

  @override
  _DropDownCategoriesState createState() => _DropDownCategoriesState();
}

class _DropDownCategoriesState extends State<DropDownCategories> {
  CreateClotheBloc createClotheBloc = new CreateClotheBloc();

  @override
  void initState() {
    createClotheBloc.eventSink.add(CreateClotheEvent.Fetch);
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems(categories) {
    List<DropdownMenuItem<String>> items = new List();
    for (String type in categories) {
      items.add(new DropdownMenuItem(value: type, child: new Text(type)));
    }
    return items;
  }

  void changedDropDownItem(String selectedType) {
    widget.callback(selectedType);
  }


  @override
  void dispose() {
    createClotheBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth * 0.9,
      padding: new EdgeInsets.fromLTRB(24.w, 48.h, 24.w, 48.h),
      child: Container(
        padding: new EdgeInsets.only(left: 50.w, right: 50.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: stylishBorderRadius,
          border: Border.all(
              color: Colors.grey,
              style: BorderStyle.solid,
              width: 3.w),
        ),
        child: StreamBuilder<List<String>>(
            stream: createClotheBloc.mainStream,
            builder: (context, snapshot) {
              if(snapshot.hasData && snapshot.data.length > 0){
                return DropdownButton<String>(
                  hint: Text("Select a type"),
                  value: widget.currentType,
                  items: getDropDownMenuItems(snapshot.data),
                  isExpanded: true,
                  onChanged: changedDropDownItem,
                );
              }else{
                return Center(child: CircularProgressIndicator());
              }
            }
        ),
      ),
    );
  }
}
