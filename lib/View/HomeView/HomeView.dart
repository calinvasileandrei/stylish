import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stylish/DB/DataAccessObject/CategoryClotheDao.dart';
import 'package:stylish/DB/DataAccessObject/CategoryDao.dart';
import 'package:stylish/Models/Clothe.dart';
import 'package:stylish/Utils/StylishSkeleton.dart';
import 'package:stylish/View/HomeView/Components/ListCategoryBuilder.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

final categorysMapProvider =
    FutureProvider<Map<String, List<Clothe>>>((ref) async {
  CategoryClotheDao categoryClotheDao = new CategoryClotheDao();
  return await categoryClotheDao.getHomeViewCategory();
});

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    super.initState();
    CategoryClotheDao categoryClotheDao = new CategoryClotheDao();
    categoryClotheDao.hasCategorysInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final categories = watch(categorysMapProvider);
      return categories.map(
        data: (_categorys) => StylishSkeleton(
          subtitle: "Choose your outfit",
          child: ListCategoryBuilder(categorys: _categorys.value),
        ),
        error: (_error) => StylishSkeleton(
            subtitle: "Choose your outfit",
            child: Text(
              _error.toString(),
              style: TextStyle(color: Colors.red),
            )),
        loading: (_) => StylishSkeleton(
          subtitle: "Choose your outfit",
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    });
  }
}
