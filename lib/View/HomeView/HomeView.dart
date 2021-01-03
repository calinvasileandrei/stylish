import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:stylish/DB/DataAccessObject/CategoryClotheDao.dart';
import 'package:stylish/DB/DataAccessObject/CategoryDao.dart';
import 'package:stylish/Models/Clothe.dart';
import 'package:stylish/Utils/StylishSkeleton.dart';
import 'package:stylish/View/HomeView/Components/ListCategoryBuilder.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final categories  = new Map<String,List<Clothe>>();

  @override
  Widget build(BuildContext context) {
    return  StylishSkeleton(
      subtitle: "Choose your outfit",
      child: ListCategoryBuilder(categorys: categories),
    );
  }
}
