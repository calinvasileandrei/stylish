import 'package:flutter/material.dart';
import 'package:stylish/Models/Clothe.dart';
import 'package:stylish/View/HomeView/Components/ClotheWidget.dart';

class CategoryBuilder extends StatelessWidget {
  CategoryBuilder(this.items,this.categoryName);
  final List<Clothe> items;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length ,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context,index){
          return new ClotheWidget(index,items[index]);
        });
  }
}
