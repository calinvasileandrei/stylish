import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:stylish/DB/DataAccessObject/CategoryClotheDao.dart';
import 'package:stylish/DB/DataAccessObject/CategoryDao.dart';
import 'package:stylish/DB/DataAccessObject/ClotheDao.dart';
import 'package:stylish/Models/Clothe.dart';
import 'package:stylish/Models/CategoryClothes.dart';
import 'package:stylish/Utils/StylishSkeleton.dart';
import 'package:stylish/View/HomeView/Components/ListCategoryBuilder.dart';
import 'package:stylish/View/HomeView/bloc/HomeBloc.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final homeBloc = new HomeBloc();

  @override
  void initState() {
    homeBloc.eventSink.add(HomeEvent.DeleteAll);
    homeBloc.eventSink.add(HomeEvent.Init);
    super.initState();
  }

  //TODO: remove only for debug
  void clothedata() async{
    ClotheDao clotheDao = new ClotheDao();
    CategoryDao categoryDao = new CategoryDao();
    final clothe =await clotheDao.getAllSortedByName();
    log("all clothe: $clothe");

    final category = await categoryDao.getAllSortedByName();
    log("all category: $category");
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: homeBloc.homeStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StylishSkeleton(
              subtitle: "Choose your outfit",
              child: ListCategoryBuilder(categoryClothes: snapshot.data),
            );
          } else if (snapshot.hasError) {
            return StylishSkeleton(
              subtitle: "Choose your outfit",
              child: Center(child: Text("Something went wrong! Ops!")),
            );
          } else {
            return StylishSkeleton(
              subtitle: "Choose your outfit",
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
